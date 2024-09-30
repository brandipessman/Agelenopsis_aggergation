library(ggplot2)
library(ggpubr)
library(broom)
library(broom.mixed)

residual_plots <- function(model, data) {
  # Augment the model with the data
  #test_data <- data.frame(
  #  .fitted = fitted(model),
  #  .resid = residuals(model)
  #)
  test_data <- augment(model, data = data)
  
  # Residuals vs Fitted plot
  resid_plot <- ggplot(test_data, aes(x = .fitted, y = .resid)) + 
    geom_point() + 
    geom_smooth(method = "loess") +
    geom_hline(yintercept = 0) +
    xlab("Fitted Values") +
    ylab("Standardized \nResiduals") +
    theme_classic() +
    theme(text = element_text(size = 14, color = "black")) +
    theme(axis.text.x=element_text(color="black", size=14)) + 
    theme(axis.text.y=element_text(color="black", size=14))
  
  # QQ plot
  y <- quantile(test_data$.resid, c(0.25, 0.75))
  x <- qnorm(c(0.25, 0.75))
  slope <- diff(y) / diff(x)
  int <- y[1L] - slope * x[1L]
  
  qq_plot <- ggplot(test_data, aes(sample = .resid)) + 
    stat_qq() + 
    geom_abline(slope = slope, intercept = int) +
    xlab("Theoretical Quantiles") +
    ylab("Sample Quantiles") +
    theme_classic() +
    theme(text = element_text(size = 14, color = "black")) +
    theme(axis.text.x=element_text(color="black", size=14)) + 
    theme(axis.text.y=element_text(color="black", size=14))  
  
  scaleloc_plot <- ggplot(test_data, aes(x = .fitted, y = sqrt(abs(.std.resid)))) + 
    geom_point() + 
    geom_smooth() + 
    geom_hline(yintercept = 0.83) +
    xlab("Fitted Values") +
    ylab("Sqrt Standardized \nResiduals") +
    theme_classic() +
    theme(text = element_text(size = 14, color = "black")) +
    theme(axis.text.x=element_text(color="black", size=14)) + 
    theme(axis.text.y=element_text(color="black", size=14))  
  
  lev_plot <- ggplot(test_data, aes(.hat, .std.resid)) +
    geom_vline(colour = "black", xintercept = 0) +
    geom_hline(colour = "black", yintercept = 0) +
    geom_point(aes(size = .cooksd)) + geom_smooth(se = FALSE) +
    xlab("Theoretical Quantiles") +
    ylab("Sample Quantiles") +
    labs(size = "Cook's \nDistance") +
    theme_classic() +
    theme(text = element_text(size = 14, color = "black")) +
    theme(axis.text.x=element_text(color="black", size=14)) + 
    theme(axis.text.y=element_text(color="black", size=14)) 
  
  # Arrange the plots side by side
  combined_plot <- ggarrange(resid_plot, qq_plot, scaleloc_plot, lev_plot, 
            labels = c("A", "B", "C", "D"),
            ncol = 2, nrow = 2)
  
  return(combined_plot)
}
