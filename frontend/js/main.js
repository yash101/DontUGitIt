(function() {
    // Setting up the map
    var map;
    window.initMap = function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
            center: {lat: 32.2319, lng: -110.9501},
            zoom: 8,
            gestureHandling: 'greedy'
        });
    };
    
    $(document).ready(function() {
        $(".main-menu").on('mouseover', function() {
            $("#map").css('left', '251px');
            console.log("Mouseover");
        });
        $(".main-menu").on('mouseout', function() {
            $("#map").css('left', '61px');
        });
    });
})();