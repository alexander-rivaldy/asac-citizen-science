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
        `var data = gon.locations['data']
        console.log(data);
        for(var sample in data){
            $('#row-'+data[sample].id).click(function(){
                if ($('#box-'+data[sample].id).css('display') === 'none')
                    $('#box-'+data[sample].id).css('display', 'block')
                else 
                    $('#box-'+data[sample].id).css('display', 'none')
            });
        }`
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
        `function(){for(var sample in data){
            (function (sample){
                var marker = new google.maps.Marker({
                            position: {lat: parseFloat(data[sample].lat), lng: parseFloat(data[sample].lng)},
                            map: map,
                            animation: google.maps.Animation.DROP,
                            icon: 'http://maps.google.com/mapfiles/arrow.png',
                            url: '/samples/' + data[sample].id
                          });
                var infowindow = new google.maps.InfoWindow({
                                content: '<p>'+data[sample].id+'</p><br/><img src="' +
                                    data[sample].photo + '" style="max-width:200px;"/>',
                                map:map,
                                position: {lat: parseFloat(data[sample].lat), lng: parseFloat(data[sample].lng)}
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
            }).call(this, sample);
            
        }}()`
        
        
    init()
