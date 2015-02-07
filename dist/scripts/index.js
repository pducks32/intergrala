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
    return lowerBoundElement.value;
  },
  get upperBound() {
    return upperBoundElement.value;
  },
  get expression() {
    return expressionElement.value;
  },
  submit: function() {
    $.ajax({
      type: "POST",
      url: "http://localhost:8000/equation",
      data: {
        equation: {
          dependentVariable: this.dependentVariable,
          independentVariable: this.independentVariable,
          integrationMethod: this.integrationMethod,
          expression: this.expression,
          upperBound: this.upperBound,
          lowerBound: this.lowerBound
        }
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

init();
