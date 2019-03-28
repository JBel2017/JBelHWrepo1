// @TODO: YOUR CODE HERE!
//initialize variables
var svgWidth = 1000;
var svgHeight = 700;
var margin = {top: 20, right:40, bottom: 60, left:100 };
var width = svgWidth - margin.left - margin.right;
var height = svgHeight - margin.top - margin.bottom;

//svg wrapper creation
var svg = d3.select('.chart').append('svg').attr('height', svgHeight).
attr('width', svgWidth).append('g').attr('transform', `translate(${margin.left}, ${margin.top})`);

var chart = svg.append('g');

//create tooltips and assign to class
d3.select('.chart').append('div').attr('class', 'tooltip').style('opacity',o);

url = "/data";
d3.json(url, function (err, data){
    if(err) throw err;


    dataset = data


    //Initialize tooltip 
    var toolTip = d3.tip().attr('class', 'tooltip').offset([80, -60]).html(function(data){
        var state = data.geography;
        return state;
    });

    chart.call(toolTip);


    //scale function ranges
    var xScale = d3.scaleLinear().range([0, width]);
    var yScale = d3.scaleLinear().range([height, 0]);

    var xAxis = d3.axisBottom().scale(xScale);
    var yAxis = d3.axisLeft().scale(yScale);

    //min and max values
    var xMin;
    var xMax;
    var yMin;
    var yMax;



    function findXValues(dataX){
        xMin = d3.min(dataset, function(d) {return d[dataX]=0.8});
        xMax = d3.max(dataset, function(d){return d[dataX]= 1.2});
    };

    function findYValues(dataY){
        yMin = d3.min(dataset, function(d) {return d[dataY]=0.8});
        yMax = d3.max(dataset, function(d){return d[dataY]= 1.2});
    };


    //default labels
    var defaultLabelX = "Percent Below Poverty"

    var defaultLabelY = "Smokers"

    findXValues(defaultLabelX)
    findYValues(defaultLabelY)

    //axis domains
    xScale.domain([xMin, xMax]);
    yScale.domain([yMin, yMax]);

    //chart creation
    chart.selectAll("circle").data(dataset).enter().append("circle").attr("cx", function(d){
        return xScale(d[defaultLabelX]);
    })
    .attr("cy", function(d){
        return yScale(d[defaultLabelY]);
    }).attr("r", 15). attr("fill", "#4380BA").attr("opacity", 0.75).on("mouseover", function(d){
        toolTip.show(d);
    })
    .on("mouseout", function(d,i){
        toolTip.hide(d);
        })
chart.selectAll("text").data(dataset).enter().append("text")
    .text(function(d){
        return d.locationAbbr;
    
    }).attr("x", function(d){
        return xScale(d[defaultLabelX]);
    }).attr("y", function(d){
        return yScale(d[defaultLabelY]);
    }).attr("font-size", "12px")
    .attr("text-anchor", "middle")
    .attr("class", "stateText")
    .on("mouseover", function(d){
        toolTip.show(d);
    })
    .on("mouseout", function(d,i){
        toolTip.hide(d);
    })
chart.append("g").attr("class", "x-axis").attr("transform", `translate(0, ${height})`).call(xAxis);

chart.append("g").attr("class", "y-axis").call(yAxis);

chart.append("text").attr("transform", `translate(${width - 40}, ${height -5})`).attr("class", "axis-text-main").text("Demographics")

chart.append("text").attr("transform", `translate(15,60)rotate(270)`).attr("class", "axis-text-main").text("BehavioralRiskFactors");

chart.append("text").attr("transform", `translate(${width/2}, ${height + 40})`).attr("class", "axis-text-x active").attr("data-axis-name", "percentBelowPoverty")
    .text("In Poverty(%)");

chart.append("text").attr("transform", `translate(${width/2}, ${height + 60})`).attr("class", "axis-text-x inactive").attr("data-axis-name", "medianIncome")
    .text("Household Income (Median)");

chart.append("text").attr("transform", `translate(${width/2}, ${height + 80})`).attr("class", "axis-text-x inactive").attr("data-axis-name", "ageDependencyRatio")
    .text("Age Dependency Ratio");

    //y-axis
chart.append("text").attr("transform", `translate(-40, ${height/2})rotate(270)`).attr("class", "axis-text-y active").attr("data-axis-name", "smokers")
    .text("Smokes (%)");

chart.append("text").attr("transform", `translate(-60, ${height/2})rotate(270)`).attr("class", "axis-text-y inactive").attr("data-axis-name", "alcoholCOnsumption")
    .text("Alcohol Consumption (%)");
    
chart.append("text").attr("transform", `translate(-80, ${height/2})rotate(270)`).attr("class", "axis-text-y inactive").attr("data-axis-name", "physicallyActive")
    .text("Physically Active (%)");



//changing the x-axis status
function labelChangeX(clickedAxis){
    d3.selectAll("axis-text-x").filter(".active").classed("active", false).classed("inactive", true);

    clickedAxis.classed("inactive", false).classed("active", true);
}

function labelChangeY(clickedAxis){
    d3.selectAll("axis-text-y").filter(".active").classed("active", false).classed("inactive", true);

    clickedAxis.classed("inactive", false).classed("active", true);
}

d3.selectAll(".axis-text-x").on("click", function () {
 
    // assign the variable to the current axis
    var clickedSelection = d3.select(this);
    var isClickedSelectionInactive = clickedSelection.classed("inactive");
    console.log("this axis is inactive", isClickedSelectionInactive)
    var clickedAxis = clickedSelection.attr("data-axis-name");
    console.log("current axis: ", clickedAxis);

    if (isClickedSelectionInactive) {
        currentAxisLabelX = clickedAxis;

        findMinAndMaxX(currentAxisLabelX);

        xScale.domain([xMin, xMax]);

        // create x-axis
        svg.select(".x-axis")
            .transition()
            .duration(1000)
            .ease(d3.easeLinear)
            .call(xAxis);

        d3.selectAll("circle")
            .transition()
            .duration(1000)
            .ease(d3.easeLinear)
            .on("start", function () {
                d3.select(this)
                    .attr("opacity", 0.50)
                    .attr("r", 20)

            })
            .attr("cx", function (d) {
                return xScale(d[currentAxisLabelX]);
            })
            .on("end", function () {
                d3.select(this)
                    .transition()
                    .duration(500)
                    .attr("r", 15)
                    .attr("fill", "#4380BA")
                    .attr("opacity", 0.75);
            })

        d3.selectAll(".stateText")
                .transition()
                .duration(1000)
                .ease(d3.easeLinear)
                .attr("x", function (d) {
                    return xScale(d[currentAxisLabelX]);
                })



        labelChangeX(clickedSelection);
    }
});

// On click events for the y-axis
d3.selectAll(".axis-text-y").on("click", function () {

    // assign the variable to the current axis
    var clickedSelection = d3.select(this);
    var isClickedSelectionInactive = clickedSelection.classed("inactive");
    console.log("this axis is inactive", isClickedSelectionInactive)
    var clickedAxis = clickedSelection.attr("data-axis-name");
    console.log("current axis: ", clickedAxis);

    if (isClickedSelectionInactive) {
        currentAxisLabelY = clickedAxis;

        findMinAndMaxY(currentAxisLabelY);

        yScale.domain([yMin, yMax]);

        // create y-axis
        svg.select(".y-axis")
            .transition()
            .duration(1000)
            .ease(d3.easeLinear)
            .call(yAxis);

        d3.selectAll("circle")
            .transition()
            .duration(1000)
            .ease(d3.easeLinear)
            .on("start", function () {
                d3.select(this)
                    .attr("opacity", 0.50)
                    .attr("r", 20)

            })
            .attr("cy", function (data) {
                return yScale(data[currentAxisLabelY]);
            })
            .on("end", function () {
                d3.select(this)
                    .transition()
                    .duration(500)
                    .attr("r", 15)
                    .attr("fill", "#4380BA")
                    .attr("opacity", 0.75);
            })

        d3.selectAll(".stateText")
            .transition()
            .duration(1000)
            .ease(d3.easeLinear)
            .attr("y", function (d) {
                return yScale(d[currentAxisLabelY]);
            })

        labelChangeY(clickedSelection);

    }

});

});

