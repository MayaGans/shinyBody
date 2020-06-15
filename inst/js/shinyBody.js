var shinyBodyBinding = new Shiny.InputBinding();
$.extend(shinyBodyBinding, {

  // find the dom element with input$id
  // this becomes el downstream
  find: function find(scope) {
    return $(scope).find(".human-body")
  },

  // get the data-anatomy of the element with class selected
  // use this as the input's value
  // SEE subscribe
  getValue: function getValue(el) {
    var value = $(el).find('.selected').data('anatomy')
    console.log(value)
    return value
  },

  // on click, remove any previous selected classes
  // then add the selected class to the clicked limb
  // this is used in getValue
  subscribe: function(el, callback) {
    $(el).on("click.shinyBodyBinding", function(evt) {
      // remove all of the selected classes inside our element
      $(el).find(".selected").removeClass("selected");
      // set the selected class to the closest clicked part
      //console.log($(evt.target).attr('id'))
      $(evt.target).addClass('selected');
      callback();
    })
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
