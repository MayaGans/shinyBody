// when you click a class .part inside a .human-body....
// but what if you have multiple bodyInputs on a single page?
$(document).on("click", ".human-body > .part", function(evt) {
  // stole the closest function from the group button
  // do I need that here?
  // could just be as simple as $(evt.target) ??
 var el = $(evt.target).closest('.part');
 console.log(el)
});


var shinyBodyBinding = new Shiny.InputBinding();
$.extend(shinyBodyBinding, {
  find: function find(scope) {
    return $(scope).find(".shinyBody-btn-group[id]");
  },
  //getType: (el) => "shinyBody.buttonGroup",
  getValue: function getValue(el) {
    // is .part right here? I _think_ I want to find the closest .part?
    // ps have no idea whats actually happening here
    var value = $(el).find(".part").map(function () {
      return this.value;
    }).get();

    if (value.length > 0) {
      return value;
    } else {
      return null;
    }
  },
  // not sure what is happening here for the button
  // and how to translate that to the body part
  // I don't have active buttons but I can add the active class
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
  // wtf is this
  subscribe: function(el, callback) {
    $(el).on("change.shinyBodyBinding", function(e) {
      callback();
    });
  },
  // also this
  unsubscribe: function(el) {
    $(el).off(".shinyBodyBinding");
  },
  receiveMessage: function receiveMessage(el, msg) {
    if (msg.value) {
      shinyBodyBinding.setValue(el, msg.value);
    }
  }
});

Shiny.inputBindings.register(shinyBodyBinding, 'shinyBody.bodyInput');




/* NOT SURE WHERE TO PUT THIS BASED ON THE DATA SUPPLIED

Shiny.addCustomMessageHandler('body_data', function(color) {
  parts = color.body_part
  vals = color.values

  var obj = {};
  parts.forEach(function(item, index) {
    obj[item] = vals[index]
  })

  const assignColor = (el, value) => {
    if (value < 25) {
      el.style.fill= "blue";
    } else if (value < 50) {
      el.style.fill= "green";
    } else {
      el.style.fill= "red";
    }
  }

    setTimeout(function(){
      for (key in obj){
        const el = document.getElementById(key);
        if (obj[key] < 25) {
          el.style.fill= "#481567FF";
        } else if (obj[key] < 50) {
          el.style.fill= "#453781FF";
        } else if (obj[key] < 75) {
          el.style.fill= "#40478FF";
        } else {
          el.style.fill= "#39568CFF";
        }
        //etc.
      }
    }, 100);

})
*/
