# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ($) ->

    # Make the following global variables
    map = null
    infowindow = null
    request = null
    icons = null
    specific_icon = null
    marker = null
    markers = null
    value = null
    collection = null
    getTypes = null
    place = null
    pois = null
    
        
    
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
            
         $('#row-1').click =>
            if $('#box-1').css('display') is 'none' 
                $('#box-1').css('display', 'block')
            else 
                $('#box-1').css('display', 'none')    
         $('#row-2').click =>
            if $('#box-2').css('display') is 'none' 
                $('#box-2').css('display', 'block')
            else 
                $('#box-2').css('display', 'none')  
         $('#row-3').click =>
            if $('#box-3').css('display') is 'none' 
                $('#box-3').css('display', 'block')
            else 
                $('#box-3').css('display', 'none')  
        
        # for sample in gon.locations
        #     do =>
        #         console.log(sample['id'])
        #         $('#row-'+sample['id']).click =>
        #             console.log(sample['id'])
        #             if $('#box-'+sample['id']).css('display') is 'none' 
        #                 $('#box-'+sample['id']).css('display', 'block')
        #             else 
        #                 $('#box-'+sample['id']).css('display', 'none')
                        
                        
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
        
        console.log(gon.locations)
        for loc in gon.locations
            do ->
                infowindow = new google.maps.InfoWindow
                    content: '<p>'+loc['name']+'</p><br/><img src="' + loc['picture'] + '" style="max-width:200px;"/>' 
                    map: map
                    position: new google.maps.LatLng(loc['lat'],loc['lon'])
                marker = new google.maps.Marker
                    map: map
                    animation: google.maps.Animation.DROP
                    position: new google.maps.LatLng(loc['lat'], loc['lon'])
                    icon: 'http://maps.google.com/mapfiles/arrow.png'
                    url: '/samples/' + loc['id']
                console.log(marker)
                # google.maps.event.addListener marker, 'mouseover', => infowindow.open(map,marker)
                # google.maps.event.addListener marker, 'mouseout', => infowindow.close()
                markers.push(marker)
                
                infowindow.close()
                windows.push(infowindow)
                # google.maps.event.addListener(marker, 'click', =>markerUrl(marker.url))
        # for marker in markers
        #     google.maps.event.addListener(marker, 'click', =>markerUrl(marker.url))
        #     marker
        google.maps.event.addListener(markers[0], 'click', =>markerUrl(markers[0].url))
        google.maps.event.addListener(markers[1], 'click', =>markerUrl(markers[1].url))
        google.maps.event.addListener(markers[2], 'click', =>markerUrl(markers[2].url))
        
        google.maps.event.addListener(markers[0], 'mouseover', =>windows[0].open(map, markers[0]))
        google.maps.event.addListener(markers[0], 'mouseout', =>windows[0].close())
        google.maps.event.addListener(markers[1], 'mouseover', =>windows[1].open(map, markers[1]))
        google.maps.event.addListener(markers[1], 'mouseout', =>windows[1].close())
        google.maps.event.addListener(markers[2], 'mouseover', =>windows[2].open(map, markers[2]))
        google.maps.event.addListener(markers[2], 'mouseout', =>windows[2].close())
        # for i in [0...markers.length-1]
        #     do ->
        #         console.log(i)
        #         console.log(markers[i])
        #         console.log(windows[i])
        #         google.maps.event.addListener(markers[i], 'mouseover', =>windows[i].open(map, markers[i]))
        #         google.maps.event.addListener(markers[i], 'mouseout', =>windows[i].close())
        
       
    markerUrl = (url) ->
        window.location.href = url
    markerWindow = (marker) ->
        marker.infoWindow.open(marker.map, marker.infoWindow)
    markerClick = () ->
        alert("TEST")
    init()
