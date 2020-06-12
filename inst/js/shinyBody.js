$(document).on("click", ".shinyBody-btn-group > .part", function(evt) {

 var el = $(evt.target).closest('.part');

});

var shinyBodyBinding = new Shiny.InputBinding();
$.extend(shinyBodyBinding, {
  find: function find(scope) {
    return $(scope).find(".shinyBody-btn-group[id]");
  },
  //getType: (el) => "shinyBody.buttonGroup",
  // need to get the selected .part not sure this is the correct js here
  getValue: function getValue(el) {
    var value = $(el).find(".part").map(function () {
      return this.value;
    }).get();

    if (value.length > 0) {
      return value;
    } else {
      return null;
    }
  },
  setValue: function(el, value) {
    console.log(el.id);
    var $el = $(el);
    console.log(value);
    $el.children().removeClass('active');
    if (value.length) {
      if (!$.isArray(value)) {
        value = [value];
      }
      for (var i = 0; i < value.length; i++) {
        var button_sel = "button[value='" + value[i] + "']";
        $el.find(button_sel).addClass('active');
      }
    }
    $el.trigger("change");
  },
  subscribe: function(el, callback) {
    $(el).on("change.shinyBodyBinding", function(e) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".shinyBodyBinding");
  },
  receiveMessage: function receiveMessage(el, msg) {
    if (msg.value) {
      shinyBodyBinding.setValue(el, msg.value);
    }
  }
});

Shiny.inputBindings.register(shinyBodyGroupBinding, 'shinyBody.buttonGroup');
