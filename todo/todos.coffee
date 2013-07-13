# REQUIRE /jslibs/jquery-2.0.2.min.js
# REQUIRE /jslibs/underscore-min.js
# REQUIRE /jslibs/backbone-min.js
# REQUIRE /jslibs/backbone.localStorage-min.js

$ = jQuery
$(() ->
    window.Todo = Backbone.Model.extend(
        defaults:
            done: false
        toggle: () ->
            this.save(done: !this.get('done'))
    )

    window.TodoList = Backbone.Collection.extend(
        model: Todo,
        localStorage: new Store('todos'),

        done: () ->
            this.filter((todo) -> todo.get('done'))

        remaining: () ->
            this.without.apply(this, this.done())
    )

    window.Todos = new TodoList

    window.TodoView = Backbone.View.extend(
        tagName: 'li',
        template: _.template '''
        <div class="todo <% if(done) { print('done')} %>">
            <div class="display" title="Doubleclick for edit...">
                <input class="check" type="checkbox"
                    <% if(done) {print('checked="checked"')} %> />
                <div class="todo-content"><%= content %></div>
                <span class="icon-remove todo-destroy"></span>
            </div>
            <div class="edit">
                <input class="todo-input" type="text" value="<%= content %>" />
            </div>
        </div>
        '''
        events:
            "change     .check"         : "toggleDone",
            "dblclick   .todo-content"  : "edit",
            "click      .todo-destroy"  : "destroy",
            "keypress   .todo-input"    : "updateOnEnter",
            "blur       .todo-input"    : "close"

        initialize: () ->
            _.bindAll(this, 'render', 'close', 'remove')

            this.model.bind('change', this.render)
            this.model.bind('destroy', this.remove)

        render: () ->
            this.$el.html(this.template(this.model.toJSON()))
            this.$el.toggleClass('done', this.model.get('done'))
            this.input = this.$('.todo-input')
            this

        toggleDone: () -> 
            this.model.toggle()

        edit: () ->
            $(this.el).addClass('editing')
            this.input.focus()

        close: () ->
            console.log this.input.val()
            this.model.save(content: this.input.val())
            $(this.el).removeClass('editing')

        updateOnEnter: (e) ->
            if e.keyCode == 13
                e.target.blur()

        remove: () ->
            $(this.el).remove()

        destroy: () ->
            this.model.destroy()
    )

    window.AppView = Backbone.View.extend(
        el: $('#todoapp')
        events:
            'keypress #new-todo': 'createOnEnter',
            'click .todos-clear a': 'clearCompleted'
        
        initialize: () ->
            _.bindAll(this, 'addOne', 'addAll', 'render')
            this.input = this.$('#new-todo')
            Todos.bind('add', this.addOne)
            Todos.bind('refresh', this.addAll)
            Todos.fetch()

        addOne: (todo) ->
            view = new TodoView(model: todo)
            this.$('#todo-list').append(view.render().el)

        addAll: () ->
            Todos.each(this.addOne)

        createOnEnter: (e) ->
            if e.keyCode != 13
                return
            value = this.input.val()
            if !value
                return
            Todos.create(content: value)
            this.input.val('')

        clearCompleted: () ->
            _.each(Todos.done(), (todo) -> todo.destroy())
            false
    )
    window.App = new AppView
)
