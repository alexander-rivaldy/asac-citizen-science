# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ($) ->

    # Make the following global variables
    map = null
    markers = []
    windows = []
    init = () ->
        $('#change-map').click ->
            $('#map').css('display', 'block')
            $('#list-view').css('display', 'none')
            $('#grid-view').css('display', 'none')
        $('#change-list').click ->
            $('#map').css('display', 'none')
            $('#list-view').css('display', 'block')
            $('#grid-view').css('display', 'none')
        $('#change-grid').click ->
            $('#map').css('display', 'none')
            $('#list-view').css('display', 'none')
            $('#grid-view').css('display', 'block')
                
        `gon.locations.forEach(function(sample) {
              $('#row-'+sample['id']).click(function(){
                if ($('#box-'+sample['id']).css('display') === 'none')
                    $('#box-'+sample['id']).css('display', 'block')
                else 
                    $('#box-'+sample['id']).css('display', 'none')
              });
        });`
                        
        # Setup map options
        mapOptions =
            center: new google.maps.LatLng(-37.8136, 144.9631)
            zoom: 11
            streetViewControl: false
            panControl: false
            mapTypeId: google.maps.MapTypeId.ROADMAP
            zoomControlOptions: 
                style: google.maps.ZoomControlStyle.SMALL
            mapTypeControlOptions:
                mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']
       # Create the map with above options in div
        map = new google.maps.Map(document.getElementById("map"),mapOptions)
        
        `gon.locations.forEach(function(sample) {
                var marker = new google.maps.Marker({
                                position: {lat: sample['lat'], lng: sample['lon']},
                                map: map,
                                animation: google.maps.Animation.DROP,
                                icon: 'http://maps.google.com/mapfiles/arrow.png',
                                url: '/samples/' + sample['id']
                              });
                var infowindow = new google.maps.InfoWindow({
                                content: '<p>'+sample['name']+'</p><br/><img src="' +
                                    sample['picture'] + '" style="max-width:200px;"/>',
                                map:map,
                                position: {lat: sample['lat'], lng: sample['lon']}
                              });
                infowindow.close();
                marker.addListener('mouseover', function() {
                    infowindow.open(map, this);
                });
                
                marker.addListener('mouseout', function() {
                    infowindow.close();
                });
                marker.addListener('click', function() {
                    window.location.href = marker['url'];
                });
        });`
    init()
