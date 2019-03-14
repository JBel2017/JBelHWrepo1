// from data.js
var tableData = data;
var tbody = document.querySelector('tbody');
var datetInput = document.querySelector('#datetime');
var searchBtn = document.querySelectore('#search');
var cityInput = document.querySelector('#city');
var stateInput = document.querySelector('#state');
var countryInput = document.querySelector('#country');
var resetBtn = document.querySelector('#reset');
var shapeInput = document.querySelector('#shape');

searchBtn.addEventListener("click", handleSearchButtonClick);
resetBtn.addEventListener("click", resetData);


var filteredData = data;
var resetData = data;


function renderTable() {
    tbody.innerHTML = '';
    for (var i = 0; i<filteredData.length; i++);{
        var ufodata = filteredData[i];
        var field = Object.keys(ufodata);

        var row = tbody.insertRow(i);
        for (var j = 0; j < field.length; j++){
            var fields = field[j];
            var cell = row.insertCell(j);
            cell.innerText = ufodata[fields];
        }
    }
}
// YOUR CODE HERE!
function handleSearchButtonClick(event){
    event.preventDefault();
    var filterDate = dateInput.value.trim();
    if (filterDate!= ""){
        filteredData = dataset.filter(function(data){
            var dataDate = data.dateTime;
            return dataDate ===filterDate;
        });
    };
    
    var filterCity = cityInput.value.trim().toLowerCase();
    if (filterCity!= ""){
        filteredData = dataset.filter(function(data){
            var dataCity = data.city.toLowerCase();
            return dataCity ===filterCity;
        });
    };
    
    var filterState = stateInput.value.trim().toLowerCase();
    if (filterState!= ""){
        filteredData = dataset.filter(function(data){
            var dataState = data.state.toLowerCase();
            return dataState ===filterState;
        });
    };

    var filterShape = shapeInput.value.trim().toLowerCase();
    if (filterShape){
        filteredData = dataset.filter(function(data){
            var dataShape = data.shape.toLowerCase();
            return dataShape ===filterShape;
        });
    };

    renderTable();
}

function resetData(){
    filteredData = dataSet;
    dataInput.value = "";
    cityInput.value = "";
    stateInput.value = "";
    countryInput.value = "";
    shapeInput.value = "";
    renderTable();
}

function resetForm(){
    document.getElementById("myForm").reset();
}
renderTable();