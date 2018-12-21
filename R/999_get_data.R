
# Setup -------------------------------------------------------------------
source("R/000_libraries.R")

# Set Access Token
Sys.setenv(SPOTIFY_CLIENT_ID = '209f3c299b644b06acd255c0166fe5bb')
Sys.setenv(SPOTIFY_CLIENT_SECRET = '90d6b433d7e542e3b021f73b6a95d4b8')
access_token <- get_spotify_access_token()

# Extract Top2000 playlist tracks
top2000 <- get_playlist_audio_features(username = "Spotify", playlist_uris = "37i9dQZF1DWTMYSYpF657b")

top2000 <- 
  top2000 %>%
  add_rownames(var = "position") %>%
  mutate(position = as.numeric(position))

glimpse(tracks)

# What key is most dominant?
tracks$key %>% table %>% sort(decreasing = T)



