library(leaflet)
library(dplyr)
library(shiny)
library(htmltools)

df <- read.csv("/Users/christophermarsicano/Dropbox/Data Viz/Confederate Statues/CSAonCampus.csv")
df1 <- subset(df, Status==1)
df2 <- subset(df, Status==2)
df3 <- subset(df, Status==3)

tealcannon <- makeIcon("https://chrismarsicano.files.wordpress.com/2017/09/tealcannon1.png",
                        "https://chrismarsicano.files.wordpress.com/2017/09/tealcannon1.png", 60, 60)

purplehat <- makeIcon("https://chrismarsicano.files.wordpress.com/2017/09/purplehat.png",
                       "https://chrismarsicano.files.wordpress.com/2017/09/purplehat.png", 40, 40)

orangex <- makeIcon("https://chrismarsicano.files.wordpress.com/2017/09/orangex.png",
                     "https://chrismarsicano.files.wordpress.com/2017/09/orangex.png", 40, 40)

html_legend <- "<img src='https://chrismarsicano.files.wordpress.com/2017/09/tealcannon1.png' height=20 width=20>Confederate Monument<br/>
                <img src='https://chrismarsicano.files.wordpress.com/2017/09/purplehat.png' height=20 width=20>Monument to Benefactor<br/>
                <img src='https://chrismarsicano.files.wordpress.com/2017/09/orangex.png' height=20 width=20>Monument Removed or Relocated"

mymap<-leaflet()%>%
       addProviderTiles(providers$Esri.WorldGrayCanvas) %>%
       addMarkers(data=df1, ~Longitude, ~Latitude , icon = tealcannon, group="Monuments to the Confederacy",
                                                  popup= paste(sep = "<br/>",
                                                  paste("<b>", "<a href='",df1$Source,"'>",df1$Memorial, "</a></b>"),
                                                  paste("<i>", df1$School, "</i>"),
                                                  " ",
                                                  df1$Description)) %>%
      addMarkers(data=df2, ~Longitude, ~Latitude , icon = purplehat, group="Monuments to Benefactors",
                          popup= paste(sep = "<br/>",
                          paste("<b>", "<a href='",df2$Source,"'>",df2$Memorial, "</a></b>"),
                          paste("<i>", df2$School, "</i>"),
                          " ",
                          df1$Description)) %>%
       addMarkers(data=df3, ~Longitude, ~Latitude , icon = orangex, group="Monuments Removed or Relocated",
             popup= paste(sep = "<br/>",
                          paste("<b>", "<a href='",df3$Source,"'>",df3$Memorial, "</a></b>"),
                          paste("<i>", df3$School, "</i>"),
                          " ",
                          df3$Description)) %>%
  ##addLegend("bottomright", colors = c("#96DFDF", "#6C1F9F", "#F29121"), labels = c("Confederate Monuments", 
  ##                                                                                 "Monuments for Service to Institution", 
  ##                                                                                 "Monuments removed or relocated")) %>%
  addLayersControl(
  overlayGroups = c("Monuments to the Confederacy", "Monuments to Benefactors", "Monuments Removed or Relocated"),
  options = layersControlOptions(collapsed = FALSE)
) %>%
  addControl(html = html_legend, position = "bottomleft")

