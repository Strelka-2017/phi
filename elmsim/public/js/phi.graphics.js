var xScale = d3.scaleLinear()
    .domain([0, 1920])
    .range([0, 1920]);

var yScale = d3.scaleLinear()
    .domain([0,1080])
    .range([0, 1080]);

function setX(node) {
    return xScale(node.label.pos.x);
}

function setY(node) {
    return yScale(node.label.pos.y);
}

function isGenerator(d) {
    return d.label.nodeType == "generator" && ["solarPanel", "windTurbine"].indexOf(d.label.generatorType > -1);
}

function generatorInitialShadow()
{
    return d3.symbol()
        .size(0)
        .type(nodeShape);
}

function transactionShadow() {
    return d3.symbol()
        .size(function (d) {
            if (isGenerator(d)) {
                return 70 + 500 * (d.label.dailyGeneration[0] || 0);
            } else {
                return 0;
            }
        })
        .type(nodeShape);
}

function nodeShape(d) {
    var defaultSymbol = d3.symbolCircle;
    switch (d.label.nodeType) {
        case "peer":
            return d3.symbolCircle;

        case "generator" :
            switch (d.label.generatorType) {
                case "windTurbine":
                    //return d3.symbolTriangle;
                case "solarPanel":
                    return d3.symbolSquare;
                default:
                    //return defaultSymbol;
                    return d3.symbolSquare;
            }

        default:
            return defaultSymbol;
    }
}

function peerSize(d) {
    if (d.label.nodeType == "peer") {
        return 8 + 2 * (d.label.desiredConsumption || 0);
    }
}

function peerSizeOuter(d) {
    if (d.label.nodeType == "peer") {
        return 8 + 2 * (d.label.desiredConsumption || 0);
    }
}

function peerFullOutline() {
    return d3.arc()
        .innerRadius(peerSize)
        .outerRadius(peerSize)
        .startAngle(0)
        .endAngle(2 * Math.PI);
}

function peerOutline() {
    return d3.arc()
        .innerRadius(peerSize)
        .outerRadius(peerSizeOuter)
        .startAngle(0)
        .endAngle(function(d){
            return d.label.actualConsumption && d.label.actualConsumption.length
                ? Math.min(2 * Math.PI, 2 * Math.PI * d.label.actualConsumption[0]/ d.label.desiredConsumption)
                : 0
        } );
}

function addBaseNode() {
    return d3.symbol()
        .size(100)
        .type(nodeShape);
}