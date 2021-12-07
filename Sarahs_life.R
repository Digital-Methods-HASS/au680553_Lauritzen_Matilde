# Sarah's life

### By Christian, Matilde & Sarah



#### We did this to get rid of excess columns in our spreadsheet. 
tail(Sarahs_FavoritePlacesDM2021,10)
Sarahs_FavoritePlacesDM2021 <- Sarahs_FavoritePlacesDM2021[1:32,]

# Activate the libraries
library(leaflet)
library(htmlwidgets)

# First, create labels for your points
placename <- Sarahs_FavoritePlacesDM2021$Placename
popup = c(placename)

# load the coordinates in the map and check: are any points missing? Why?
leaflet() %>% 
  addTiles() %>% 
  addMarkers(lng = Sarahs_FavoritePlacesDM2021$Longitude, 
             lat = as.numeric(Sarahs_FavoritePlacesDM2021$Latitude),
             popup = Sarahs_FavoritePlacesDM2021$Placename)
?read_sheet

# We tried something - it did'nt work
places <- read_sheet("https://docs.google.com/spreadsheets/d/1PlxsPElZML8LZKyXbqdAYeQCDIvDps2McZx1cTVWSzI/edit#gid=2056989315",
                     col_types = "cccnncnc",range="A1:G33")

## Task 2 
leaflet() %>%
  setView(10.202056,56.1715369, zoom = 13) %>%
  addTiles()  # checking I am in the right area

s_DAN<-leaflet() %>%
  setView(10.202056,56.1715369, zoom = 13)

for (provider in esri) {
  s_DAN <- s_DAN %>% addProviderTiles(provider, group = provider)
}

DANmap <- s_DAN %>%
  addLayersControl(baseGroups = names(esri),
                   options = layersControlOptions(collapsed = FALSE)) %>%
  addMiniMap(tiles = esri[[1]], toggleDisplay = TRUE,
             position = "bottomright") %>%
  addMeasure(
    position = "bottomleft",
    primaryLengthUnit = "meters",
    primaryAreaUnit = "sqmeters",
    activeColor = "#3D535D",
    completedColor = "#7D4479") %>%
  htmlwidgets::onRender("
                        function(el, x) {
                        var myMap = this;
                        myMap.on('baselayerchange',
                        function (e) {
                        myMap.minimap.changeLayer(L.tileLayer.provider(e.name));
                        })
                        }") %>%
  addControl("", position = "topright") %>% 
  addMarkers(lng = Sarahs_FavoritePlacesDM2021$Longitude, 
             lat = as.numeric(Sarahs_FavoritePlacesDM2021$Latitude),
             popup = Sarahs_FavoritePlacesDM2021$Placename, 
clusterOptions = markerClusterOptions())



DANmap

# Task 3 - cluster

#### We used this function, to cluster the popups together on the map. 
##### We added this chunk of code into the addMarkers() part of our longer code.

clusterOptions = markerClusterOptions()


# Task 4. 

#### It looks nicer, and it's easier to see the popups. It's also easier to disect where Sarah's been most active in her life. 


# Task 5: Find out how to display notes and classifications in the map.

#### For this task we'll use the popup = paste() function, as it's possible to display notes and classifications in the popup.
##### Because we don't have any notes, we'll use the Description column instead. We also used the Rating column. 

popup=paste("Placename:", Sarahs_FavoritePlacesDM2021$Placename,"<br>",
            "Description:", Sarahs_FavoritePlacesDM2021$Description, "<br>",
            "Rating:", Sarahs_FavoritePlacesDM2021$Stars1_5)


DANmap <- s_DAN %>%
  addLayersControl(baseGroups = names(esri),
                   options = layersControlOptions(collapsed = FALSE)) %>%
  addMiniMap(tiles = esri[[1]], toggleDisplay = TRUE,
             position = "bottomright") %>%
  addMeasure(
    position = "bottomleft",
    primaryLengthUnit = "meters",
    primaryAreaUnit = "sqmeters",
    activeColor = "#3D535D",
    completedColor = "#7D4479") %>%
  htmlwidgets::onRender("
                        function(el, x) {
                        var myMap = this;
                        myMap.on('baselayerchange',
                        function (e) {
                        myMap.minimap.changeLayer(L.tileLayer.provider(e.name));
                        })
                        }") %>%
  addControl("", position = "topright") %>% 
  addMarkers(lng = Sarahs_FavoritePlacesDM2021$Longitude, 
             lat = as.numeric(Sarahs_FavoritePlacesDM2021$Latitude),
             clusterOptions = markerClusterOptions(),
             popup = paste ("Placename:", Sarahs_FavoritePlacesDM2021$Placename,"<br>",
                         "Description:", Sarahs_FavoritePlacesDM2021$Description, "<br>",
                         "Rating:", Sarahs_FavoritePlacesDM2021$Stars1_5))

DANmap

