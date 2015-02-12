createUpdateFunction = function(element) {
  return function() {
    updateEach(element);
  };
};

equationSubmitButton = $("#equationSubmitButton");
equationForm = $("#equationForm");

expressionElement = $("[data-expression]");

integrationMethodElement = $("[data-integration-method]");
dependentVariableElement = $("[data-dependent-variable]");

lowerBoundElement = $("[data-lower-bound]");
upperBoundElement = $("[data-upper-bound]");

boundVariableElement = $("[data-bound-variable]");
boundVariableElement.update = function() {
  boundVariableElement.text(equation.boundVariable);
};

dependentVariableListeners = [boundVariableElement];
dependentVariableListeners.update = createUpdateFunction(dependentVariableListeners);

integrationMethodListeners = [boundVariableElement];
integrationMethodListeners.update = createUpdateFunction(integrationMethodListeners);

equation = {
  get dependentVariable() {
    return dependentVariableElement.children("option:selected")[0].value;
  },
  get independentVariable() {
    return this.dependentVariable == "x" ? "y" : "x";
  },
  get integrationMethod() {
    return integrationMethodElement.children("option:selected")[0].value;
  },
  get boundVariable() {
    return (this.integrationMethod == "disk" ? this.independentVariable : this.dependentVariable);
  },
  get lowerBound() {
    return lowerBoundElement.val();
  },
  get upperBound() {
    return upperBoundElement.val();
  },
  get expression() {
    return expressionElement.val();
  },
  toJSON: function() {
    data = {
      "dependentVariable": this.dependentVariable,
      "independentVariable": this.independentVariable,
      "integrationMethod": this.integrationMethod,
      "expression": this.expression,
      "upperBound": this.upperBound,
      "lowerBound": this.lowerBound
    };
    return JSON.stringify(data);
  },
  submit: function() {
    data = this.toJSON();
    console.log(data);
    $.ajax({
      type: "POST",
      url: "/equation",
      contentType: "application/json; charset=utf-8",
      data: data,
      success: function(data) {
        console.log(data);
        render(data);
      }
    });
  }
};

init = function() {
  attachListeners();
  dependentVariableListeners.update();
  integrationMethodListeners.update();
};

attachListeners = function() {
  dependentVariableElement.on("change", dependentVariableListeners.update);
  integrationMethodElement.on("change", integrationMethodListeners.update);
  equationForm.submit(function(event){
    event.preventDefault();
    equation.submit();
  });
};

createUpdateFunction = function(element) {
  return function() {
    updateEach(element);
  };
};

updateEach = function(container) {
  $.each(container, function(index, element) {
    element.update();
  });
};

checkBounds = function() {
  return equation.lowerBound < equation.upperBound;
};

render = function(data) {
  console.log("Rendering");
  string = "<div data-expr='" + data.latex + " = " + data.volume + "'></div>";
  $latex = $(string);
  $(".rendering").first().empty().append($latex);

  var tex = document.querySelectorAll("[data-expr]");
  Array.prototype.forEach.call(tex, function(el) {
    katex.render(el.getAttribute("data-expr"), el);
  });
};

init();
