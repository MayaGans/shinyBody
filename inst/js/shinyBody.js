var shinyBodyBinding = new Shiny.InputBinding();
$.extend(shinyBodyBinding, {

  // find the descendant elements of class "human-body"
  // and within that class "part"
  find: function find(scope) {
    return $(scope).find(".human-body > .part")
  },

  // now we set what we want to return when the user calls input$id
  getValue: function getValue(el) {
    var value = $(el).data('position')
    // this works! why doesn't this show up
    // I only see NULL
    console.log(value)
    return value
  },


  // docs show this is a feature thats not even used
  // setValue: function(el, value) {
  //  var $el = el
  //  $el.trigger("click");
  // },

  // listens for specific events on our component
  subscribe: function(el, callback) {
    $(el).on("click.shinyBodyBinding", function(e) {
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
