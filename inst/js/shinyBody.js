// when you click a class .part inside a .human-body....
// but what if you have multiple bodyInputs on a single page?
$(document).on("click", ".human-body > .part", function(evt) {
  // stole the closest function from the group button
  // I think I need to get the id attribute from each svg
 var el = $(this).attr('id')
 // THIS IS WORKING!
 // HOW DO I GET THE ID TO BECOME THE OUTPUT!
 // console.log(el)
});


var shinyBodyBinding = new Shiny.InputBinding();
$.extend(shinyBodyBinding, {
  find: function find(scope) {
    return $(scope).find(".human-body > .part")
  },
  // do I need this?
  // Garrick didn't have it....
  //initialize: function(el){
  //   var state = $(el).data("position");
  //},
  getValue: function getValue(el) {
    // this is what I want!
    // How do I get this to become the input$id value!!!!
    var value = $(el).data('position')
    console.log(value)
    return value
  },
  //setValue: function(el, value) {
  //  var $el = el
  //  $el.trigger("click");
  //},
  // wtf is this
  subscribe: function(el, callback) {
    $(el).on("click.shinyBodyBinding", function(e) {
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
