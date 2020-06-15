var shinyBodyBinding = new Shiny.InputBinding();
$.extend(shinyBodyBinding, {

  // find the dom element with input$id
  find: function find(scope) {
    return $(scope).find(".human-body")
  },

  // now we set what we want to return when the user calls input$id
  getValue: function getValue(el) {
    var value = $(el).find('.selected').data('position')
    console.log(value)
    return value
  },


  // docs show this is a feature thats not even used...?
  // setValue: function(el, value) {
  //  var $el = el
  //  $el.trigger("click");
  // },

  // subscribe listens for specific events on our component
  /* I specified click if click,
  so why when I first open the app
  do I see all the parts?
  Then, as expected, on subsequent clicks
  I only see the part that was clicked on */
  subscribe: function(el, callback) {
    $(el).on("click.shinyBodyBinding", function(e) {
      $(document).find(".selected").removeClass("selected");
      $(el).find('.part').addClass('selected');
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".shinyBodyBinding");
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
