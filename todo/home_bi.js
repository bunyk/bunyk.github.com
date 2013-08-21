// Generated by CoffeeScript 1.6.1
(function() {
  var $;

  $ = jQuery;

  $(function() {
    var createTableWidget;
    createTableWidget = function(element, table_name, schema) {
      /*
      #   Function creates backbone MVC with CRUD functionality
      #   for some relational table.
      #
      #   element - jquery element to put widget into
      #   table_name - for backend model storage
      #   schema - list of field names
      #   TODO: add field types and appropriate widgets
      */

      var ItemList, Items, ModelItem, TableRowView, TableView, TableWidget, empty_fields, field, getTableCell, _i, _len;
      empty_fields = {};
      for (_i = 0, _len = schema.length; _i < _len; _i++) {
        field = schema[_i];
        empty_fields[field] = '';
      }
      ModelItem = Backbone.Model.extend();
      ItemList = Backbone.Collection.extend({
        model: ModelItem,
        localStorage: new Store(table_name)
      });
      Items = new ItemList;
      getTableCell = function(field_name) {
        return "<td>\n<span class=\"content\"><%= " + field_name + " %></span>\n<input class=\"input\" name=\"" + field_name + "\" type=\"text\" value=\"<%= " + field_name + " %>\"/>\n</td>";
      };
      TableRowView = Backbone.View.extend({
        tagName: 'tr',
        template: _.template(_.map(schema, getTableCell).join('') + '<td><span class="edit">✎</span></td>\n<td><span class="remove">✘</span></td>\n<td><span class="save">Save</span></td>'),
        events: {
          'click .edit': 'edit',
          'click .remove': 'remove',
          'keypress .input': 'updateOnEnter',
          'click .save': 'close'
        },
        initialize: function() {
          _.bindAll(this, 'render', 'close', 'remove');
          this.model.bind('change', this.render);
          return this.model.bind('destroy', this.remove);
        },
        render: function() {
          var i, _j, _len1;
          console.log(this.model.toJSON());
          this.$el.html(this.template(this.model.toJSON()));
          this.input = [];
          for (i = _j = 0, _len1 = schema.length; _j < _len1; i = ++_j) {
            field = schema[i];
            this.input[i] = this.$(".input[name=\"" + field + "\"]");
          }
          return this;
        },
        edit: function() {
          $(this.el).addClass('editing');
          return this.input[0].focus();
        },
        close: function() {
          var i, object, _j, _len1;
          object = {};
          for (i = _j = 0, _len1 = schema.length; _j < _len1; i = ++_j) {
            field = schema[i];
            object[field] = this.input[i].val();
          }
          this.model.save(object);
          $(this.el).removeClass('editing');
          return this.trigger('data_saved');
        },
        updateOnEnter: function(e) {
          if (e.keyCode === 13) {
            return this.close();
          }
        },
        remove: function() {
          return $(this.el).remove();
        },
        destroy: function() {
          return this.model.destroy();
        }
      });
      _.extend(TableRowView, Backbone.Events);
      TableView = Backbone.View.extend({
        el: element,
        events: {
          'click .add-new': 'addNew'
        },
        initialize: function() {
          _.bindAll(this, 'addOne', 'addAll', 'render');
          this.render();
          Items.bind('add', this.addOne);
          Items.bind('refresh', this.addAll);
          Items.fetch();
          return this.adding_state = false;
        },
        render: function() {
          this.$el.html('<table class="item-list"></table>\n<button class="add-new">Add new</button>');
          return this;
        },
        addOne: function(item) {
          var view,
            _this = this;
          view = new TableRowView({
            model: item
          });
          view.render();
          this.$('.item-list').append(view.el);
          if (this.adding_state) {
            view.edit();
            return view.on('data_saved', function() {
              return _this.adding_state = false;
            });
          }
        },
        addAll: function() {
          return Items.each(this.addOne);
        },
        addNew: function() {
          this.adding_state = true;
          return Items.create(empty_fields);
        }
      });
      return TableWidget = new TableView;
    };
    createTableWidget($('#products')[0], 'products', ['name']);
    return createTableWidget($('#vendors')[0], 'vendors', ['name', 'address']);
  });

}).call(this);