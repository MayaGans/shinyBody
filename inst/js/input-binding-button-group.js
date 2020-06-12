// this is Garrick Aden-Buie's code
// Using as a reference to build my own widget
// https://github.com/gadenbuie/shinyThings


$(document).on("click", ".shinyBody-btn-group > .btn", function(evt) {
  // button that was clicked
  var el = $(evt.target).closest('button');

  // toggle state of clicked button
  if (el.hasClass('active')) {
    el.removeClass('active');
  } else {
    el.addClass('active');
    if (!parseInt(el.parent().attr('data-multiple'))) {
      // deactive other buttons if only one active button allowed
      el.siblings().removeClass('active');
    }
  }

  // remove focus from button
  el.blur();

  // Raise event to signal value has changed
  el.trigger("change");
});

var shinyBodyGroupBinding = new Shiny.InputBinding();
$.extend(shinyBodyGroupBinding, {
  find: function find(scope) {
    return $(scope).find(".shinyBody-btn-group[id]");
  },
  //getType: (el) => "shinyBody.buttonGroup",
  getValue: function getValue(el) {
    var value = $(el).find(".active").map(function () {
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
    $(el).on("change.shinyBodyGroupBinding", function(e) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".shinyBodyGroupBinding");
  },
  receiveMessage: function receiveMessage(el, msg) {
    if (msg.value) {
      shinyBodyGroupBinding.setValue(el, msg.value);
    }
  }
});

Shiny.inputBindings.register(shinyBodyGroupBinding, 'shinyBody.buttonGroup');
