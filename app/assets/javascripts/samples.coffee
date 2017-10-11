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
            window.location.href = '/map'
        $('#change-list').click ->
            window.location.href = '/list'
        $('#change-grid').click ->
            window.location.href = '/grid'
        `
        var data = gon.locations['data'];
        console.log(data);
        
        for(var sample in data){
            (function (sample){
                if ($('#row-'+data[sample].id).hasClass('active')) {
                    $('#box-'+data[sample].id).css('display', 'block')
                }
                
                $('#row-'+data[sample].id).click(function(){
                    $('.row-h1').removeClass('active');
                    $('#row-'+data[sample].id).addClass('active');
                    $('.tab-pane').css('display', 'none');
                    
                    if ($('#box-'+data[sample].id).css('display') === 'none')
                        $('#box-'+data[sample].id).css('display', 'block')
                    else 
                        $('#box-'+data[sample].id).css('display', 'none')
                });
            }).call(this, sample);
            
        }
        
        
        `
        # Setup map options
        mapOptions =
            center: new google.maps.LatLng(-37.8136, 144.9631)
            zoom: 12
            streetViewControl: true
            fullscreenControl: true
            panControl: false
            zoomControl: true
            mapTypeId: google.maps.MapTypeId.ROADMAP
            zoomControlOptions: 
                style: google.maps.ZoomControlStyle.SMALL
                position: google.maps.ControlPosition.RIGHT_BOTTOM
            mapTypeControlOptions:
                mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']
            styles: [
                { 
                    "featureType":"administrative",
                    "elementType":"labels.text.fill",
                    "stylers":[{"color":"#444444"}]
                },
                {
                    "featureType":"administrative.province",
                    "elementType":"geometry.stroke",
                    "stylers":[{"saturation":"46"}]
                },
                {
                    "featureType":"administrative.neighborhood",
                    "elementType":"geometry.fill",
                    "stylers":[{"hue":"#00ff43"}]
                },
                {
                    "featureType":"landscape",
                    "elementType":"all",
                    "stylers":[{"color":"#f2f2f2"}]
                },
                {
                    "featureType":"landscape.man_made",
                    "elementType":"geometry.fill",
                    "stylers":[{"visibility":"on"}]
                },
                {
                    "featureType":"poi",
                    "elementType":"all",
                    "stylers":[{"visibility":"off"}]
                },
                {
                    "featureType":"road",
                    "elementType":"all",
                    "stylers":[{"saturation":-100},{"lightness":45}]
                },
                {
                    "featureType":"road.highway",
                    "elementType":"all",
                    "stylers":[{"visibility":"simplified"}]
                },
                {
                    "featureType":"road.highway",
                    "elementType":"geometry.stroke",
                    "stylers":[{"visibility":"on"},{"hue":"#ff0046"}]
                },
                {
                    "featureType":"road.arterial",
                    "elementType":"labels.icon",
                    "stylers":[{"visibility":"off"}]
                },
                {
                    "featureType":"transit",
                    "elementType":"all",
                    "stylers":[{"visibility":"off"}]
                },
                {
                    "featureType":"transit.line",
                    "elementType":"geometry.fill",
                    "stylers":[{"hue":"#ff0041"}]
                },
                {
                    "featureType":"transit.station.airport",
                    "elementType":"geometry.fill",
                    "stylers":[{"visibility":"on"},{"color":"#f2f2f2"}]
                },
                {
                    "featureType":"transit.station.airport",
                    "elementType":"labels.text.fill",
                    "stylers":[{"color":"#f2f2f2"}]
                },
                {
                    "featureType":"water",
                    "elementType":"all",
                    "stylers":[{"color":"#00617f"},{"visibility":"on"}]
                }]
       # Create the map with above options in div
        map = new google.maps.Map(document.getElementById("map"), mapOptions) 
        `function(){for(var sample in data){
            (function (sample){
                var marker = new google.maps.Marker({
                            position: {lat: parseFloat(data[sample].lat), lng: parseFloat(data[sample].lng)},
                            map: map,
                            animation: google.maps.Animation.DROP,
                            icon: 'http://maps.google.com/mapfiles/marker.png',
                            url: '/samples/' + data[sample].id
                          });
                var content = '<div class="info-window">' + 
                                '<p>' + data[sample].id + '</p>' +
                                '<img src="' + data[sample].photo + '" class="info-photo"/>' +
                                '</div>';
                var infowindow = new google.maps.InfoWindow({
                                content: content,
                                map:map,
                                position: {lat: parseFloat(data[sample].lat), lng: parseFloat(data[sample].lng)},
                                padding: 0,
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
                
                google.maps.event.addListener(infowindow, 'domready', function() {
                    var iwOuter = $('.gm-style-iw');
            
                    var iwBackground = iwOuter.prev();
                
                    iwBackground.children(':nth-child(2)').css({'display' : 'none'});
                
                    iwBackground.children(':nth-child(4)').css({'display' : 'none'});
                    
                    iwBackground.children(':nth-child(1)').attr('style', function(i,s)
                    { return s + 'display: none !important;'});
                    
                });
                

            }).call(this, sample);
            
        }}()
        
       `
        
        
    init()
    `function(){
          var input = document.getElementById('pac-input');
          var searchBox = new google.maps.places.SearchBox(input);
          map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
        
          // Bias the SearchBox results towards current map's viewport.
          map.addListener('bounds_changed', function() {
            searchBox.setBounds(map.getBounds());
          });
        
          var markers = [];
          // Listen for the event fired when the user selects a prediction and retrieve
          // more details for that place.
          searchBox.addListener('places_changed', function() {
            var places = searchBox.getPlaces();
        
            if (places.length == 0) {
              return;
            }
        
             // For each place, get the icon, name and location.
            var bounds = new google.maps.LatLngBounds();
            places.forEach(function(place) {
              if (!place.geometry) {
                console.log("Returned place contains no geometry");
                return;
              }
              
              if (place.geometry.viewport) {
                // Only geocodes have viewport.
                bounds.union(place.geometry.viewport);
              } else {
                bounds.extend(place.geometry.location);
              }
            });
            map.fitBounds(bounds);
          });
        }.call(this);`
