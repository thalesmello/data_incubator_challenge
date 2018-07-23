require(dplyr)
require(readr)
require(tidyr)
require(ggplot2)

github <- read_csv("github.csv")

cum_github <- github %>%
  group_by(repository_name, type) %>%
  arrange(repository_name, type, event_date) %>%
  mutate(cum_total = cumsum(total_events)) %>%
  rename(event_type=type)

qplot(event_date, cum_total, color = repository_name, facets = event_type~., data = cum_github, geom = "line")
qplot(event_date, total_events, color = repository_name, facets = event_type~., data = cum_github %>% filter(event_date >= '2017-01-01' & event_date <= '2017-01-31'), geom = "line") + scale_y_log10()