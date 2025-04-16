library(tidyverse)
library(here)

here::i_am("Jeffrey_Code/filter_data.R")

AllData = read.csv(here("Data/nba_2025-03-07"))

#Create conference column

# Named vector mapping team abbreviations to conferences
conference_map <- c(
  ATL = "East", BOS = "East", BKN = "East", CHA = "East", CHI = "East", CLE = "East",
  DET = "East", IND = "East", MIA = "East", MIL = "East", NYK = "East", ORL = "East",
  PHI = "East", TOR = "East", WAS = "East",
  
  DAL = "West", DEN = "West", GSW = "West", HOU = "West", LAC = "West", LAL = "West",
  MEM = "West", MIN = "West", NOP = "West", OKC = "West", PHX = "West", POR = "West",
  SAC = "West", SAS = "West", UTA = "West"
)

# Add a conference column
AllData = AllData |>
  mutate(conference = conference_map[Team])

#Test:
#Sys.setenv(WHICH_CONFIG="one_team")

WHICH_CONFIG = Sys.getenv("WHICH_CONFIG")

config_list = config::get(config=WHICH_CONFIG)

#Filter for specified conference
if(config_list$conference %in% c("West","East")) {
  AllData = AllData |> filter(conference==config_list$conference)
}

#Filter for specified team
if(config_list$team == "CUSTOM"){
  TEAM = Sys.getenv("TEAM")
  AllData = AllData |> filter(Team==TEAM)
}

#Filter for specified position
if(config_list$position == "CUSTOM"){
  POS = Sys.getenv("POS")
  AllData = AllData |> filter(Pos==POS)
}

saveRDS(AllData,here("Clean_Data/data.rds"))


