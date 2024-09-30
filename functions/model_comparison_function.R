library(tidyverse)
library(broom)
library(ggpubr)

plot_model_comparisons <- function(data, model_nb, model_poisson, model_log, 
                                   x_var, y_var, y_limits, y_breaks, y_lab,
                                   labels = c("0", "0", "0")) {
  
  # Raw Data Plot
  raw_data <- data %>%
    group_by(Location) %>%
    summarise(mean = mean(.data[[y_var]]), se = plotrix::std.error(.data[[y_var]]))
  
  raw_plot <- ggplot(data, aes_string(x = x_var, y = y_var)) + 
    geom_jitter(color = "grey", width = 0.1) +
    geom_point(aes(x = Location, y = mean, color = Location), size = 2, data = raw_data) +
    geom_errorbar(aes(x = Location, ymin = mean - se, ymax = mean + se, color = Location), 
                  data = raw_data, inherit.aes = FALSE, width = 0.15, linewidth = 1) +
    scale_color_manual(values = c("Urban Center" = "#d95f02", "Urban Forest" = "#1b9e77")) +
    scale_x_discrete(labels=c("Urban Forest" = "Urban \nForest \nN = 10", "Urban Center" = "Urban \nCenter \nN = 12")) +
    theme_classic() +
    scale_y_continuous(limits = y_limits, breaks = y_breaks) +
    xlab("Collection Location") +
    ylab(y_lab) + 
    theme(text = element_text(size = 10)) + 
    theme(axis.text.x = element_text(colour = "black", size = 10)) + 
    theme(axis.text.y = element_text(colour = "black", size = 10),
          axis.title.x = element_blank()) +
    theme(legend.position = "none")
  
  # Poisson Predictions and Plot
  nd <- data.frame(Location = factor(levels(data[[x_var]])))
  predictions_poisson <- augment(model_poisson, newdata = nd, se_fit = TRUE, type.predict = "response") %>%
    rename("rate" = ".fitted", "SE" = ".se.fit")
  
  poisson_plot <- ggplot(data, aes_string(x = x_var, y = y_var)) + 
    geom_jitter(color = "grey", width = 0.1) +
    geom_point(aes(x = Location, y = rate, color = Location), size = 2, data = predictions_poisson) + 
    geom_errorbar(aes(x = Location, ymin = rate - SE, ymax = rate + SE, color = Location), 
                  data = predictions_poisson, inherit.aes = FALSE, width = 0.15, linewidth = 1) +
    scale_color_manual(values = c("Urban Center" = "#d95f02", "Urban Forest" = "#1b9e77")) +
    scale_x_discrete(labels=c("Urban Forest" = "Urban \nForest \nN = 10", "Urban Center" = "Urban \nCenter \nN = 12")) +
    theme_classic() +
    scale_y_continuous(limits = y_limits, breaks = y_breaks) +
    xlab("Collection Location") +
    ylab(y_lab) + 
    theme(text = element_text(size = 10)) + 
    theme(axis.text.x = element_text(colour = "black", size = 10)) + 
    theme(axis.text.y = element_text(colour = "black", size = 10),
          axis.title.x = element_blank()) +
    theme(legend.position = "none") +
    annotate(geom = "text", x = 1.5, y = y_limits[2], label = labels[1], color = "black", size = 5)
  
  # Log-Transformed Predictions and Plot
  predictions_log <- augment(model_log, newdata = nd, se_fit = TRUE, type.predict = "response") %>%
    rename("response" = ".fitted", "SE" = ".se.fit")
  
  log_plot <- ggplot(data, aes_string(x = x_var, y = y_var)) + 
    geom_jitter(color = "grey", width = 0.1) +
    geom_point(aes(x = Location, y = exp(response), color = Location), size = 2, data = predictions_log) + 
    geom_errorbar(aes(x = Location, ymin = exp(response - SE), ymax = exp(response + SE), color = Location), 
                  data = predictions_log, inherit.aes = FALSE, width = 0.15, linewidth = 1) +
    scale_color_manual(values = c("Urban Center" = "#d95f02", "Urban Forest" = "#1b9e77")) +
    scale_x_discrete(labels=c("Urban Forest" = "Urban \nForest \nN = 10", "Urban Center" = "Urban \nCenter \nN = 12")) +
    theme_classic() +
    scale_y_continuous(limits = y_limits, breaks = y_breaks) +
    xlab("Collection Location") +
    ylab(y_lab) + 
    theme(text = element_text(size = 10)) + 
    theme(axis.text.x = element_text(colour = "black", size = 10)) + 
    theme(axis.text.y = element_text(colour = "black", size = 10),
          axis.title.x = element_blank()) +
    theme(legend.position = "none") +
    annotate(geom = "text", x = 1.5, y = y_limits[2], label = labels[2], color = "black", size = 5)
  
  # Negative Binomial Predictions
  predictions_nb <- augment(model_nb, newdata = nd, se_fit = TRUE, type.predict = "response") %>%
    rename("rate" = ".fitted", "SE" = ".se.fit")
  
  # Negative Binomial Plot
  nb_plot <- ggplot(data, aes_string(x = x_var, y = y_var)) + 
    geom_jitter(color = "grey", width = 0.1) +
    geom_point(aes(x = Location, y = rate, color = Location), size = 2, data = predictions_nb) + 
    geom_errorbar(aes(x = Location, ymin = rate - SE, ymax = rate + SE, color = Location), 
                  data = predictions_nb, inherit.aes = FALSE, width = 0.15, linewidth = 1) +
    scale_color_manual(values = c("Urban Center" = "#d95f02", "Urban Forest" = "#1b9e77")) +
    scale_x_discrete(labels=c("Urban Forest" = "Urban \nForest \nN = 10", "Urban Center" = "Urban \nCenter \nN = 12")) +
    theme_classic() +
    scale_y_continuous(limits = y_limits, breaks = y_breaks) +
    xlab("Collection Location") +
    ylab(y_lab) + 
    theme(text = element_text(size = 10)) + 
    theme(axis.text.x = element_text(colour = "black", size = 10)) + 
    theme(axis.text.y = element_text(colour = "black", size = 10),
          axis.title.x = element_blank()) +
    theme(legend.position = "none") +
    annotate(geom = "text", x = 1.5, y = y_limits[2], label = labels[3], color = "black", size = 3)
  
  # Arrange Plots
  combined_plot <- ggarrange(raw_plot, 
            poisson_plot, 
            log_plot, 
            nb_plot,
            labels = c("Raw Data", "Poisson Distribution", "Log-Transformed", "Negative Binamial"),
            nrow = 1)
  
  return(combined_plot)
}
