# REQUIRE jquery
# REQUIRE underscore
# REQUIRE backbone
# REQUIRE backbone_localstorage
#
$ = jQuery
$(() ->
    window.Product = Backbone.Model.extend()
    window.ProductList = Backbone.Collection.extend(
        model: Product,
        localStorage: new Store('products')
    )
    window.Products = new ProductList

    window.ProductView = Backbone.View.extend(
        tagName: 'li',
        template: _.template '''
        <span class="content"><%= name %></span>
        <span class="edit">✎</span>
        <span class="remove">✘</span>
        <input class="input" type="text" value="<%= name %>"/>
        '''
        events:
            'click .edit': 'edit',
            'click .remove': 'remove',
            'keypress .input': 'updateOnEnter',
            'blur .input': 'close'

        initialize: () ->
            _.bindAll(this, 'render', 'close', 'remove')

            this.model.bind('change', this.render)
            this.model.bind('destroy', this.remove)

        render: () ->
            this.$el.html(this.template(this.model.toJSON()))
            this.input = this.$('.input')
            this

        edit: () ->
            $(this.el).addClass('editing')
            this.input.focus()

        close: () ->
            this.model.save(name: this.input.val())
            $(this.el).removeClass('editing')

        updateOnEnter: (e) ->
            if e.keyCode == 13
                e.target.blur()

        remove: () ->
            $(this.el).remove()

        destroy: () ->
            this.model.destroy()
    )
    window.ProductListView = Backbone.View.extend(
        el: $('#products')
        events: 
            'keypress #new-product': 'createOnEnter',

        initialize: () ->
            _.bindAll(this, 'addOne', 'addAll', 'render')
            @input = @$('#new-product')
            Products.bind('add', this.addOne)
            Products.bind('refresh', this.addAll)
            Products.fetch()

        addOne: (product) ->
            view = new ProductView(model: product)
            this.$('#product-list').append(view.render().el)

        addAll: () ->
            Products.each(@addOne)

        createOnEnter: (e) ->
            if e.keyCode != 13
                return
            value = @input.val()
            if !value
                return
            Products.create(name: value)
            @input.val('')
    )
    window.ProductListWidget = new ProductListView
)
