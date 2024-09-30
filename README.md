# Urbanization affects web abundance and aggregation of a funnel-weaving spider, *Agelenopsis pennsylvanica* (Agelenidae)

The following data and code are provided as a reference for the associated publication in [Urban Ecosystems](https://doi.org/10.1007/s11252-023-01379-z). This publication was written in association with my Ph.D. dissertation.

Access PDF: [View PDF](./manuscript.pdf)

Access Poster: [View Poster](./poster.pdf) (*Note: Poster was produced before publication and does not represent peer-reviewed results.*)

## Who:

> > 👩 Authors: **Brandi Pessman**, Madison Hays, Earl Agpawa, and Eileen Hebets

> > 🕷️ S️tudy Organism: *Agelenopsis pennsylvanica* (the funnel-weaving spider or grass spider)

## What:

> > In this study, we quantified variation in the spatial distribution (including aggregation, abundance, and position) of funnel webs between two distinct urban habitats: an urban center and an urban forest. We found that spiders in the urban center were more abundant, more aggregated, and constructed webs lower than spiders in the urban forest. We further explored potential predictors of variation in spatial distribution. Spiders were more abundant at sites with lower plant diversity and less potential impact from roads and highways. As such, we hypothesize that vibratory noise may play a key role in spider (and other arthropod) distributions in cities.

The code presented in this repository walks through the analysis of this data, including:

-   Wrangling/munging the data files ([1_data_wrangling.Rmd](./1_data_wrangling.Rmd))

-   Reducing the number of environmental predictor variables by removing highly correlated variables ([2_transformations_reductions.Rmd](./2_transformations_reductions.Rmd))

-   Running statistical analysis ([3_habitat_characteristics_nb.Rmd](./3_habitat_characteristics_nb.Rmd), [4_spider_measurements_nb.Rmd](./4_spider_measurements_nb.Rmd), [5_environmental_aic_selection.Rmd](./5_environmental_aic_selection.Rmd), [6_land_cover_posthoc_nb.Rmd](./6_land_cover_posthoc_nb.Rmd))

-   Making publication-ready figures and tables ([7_publication_figures.Rmd](./7_publication_figures.Rmd), [8_publication_tables.Rmd](./8_publication_tables.Rmd))

## When:

> > 📓 Date Collected: September-October 2020

> > 🏆 First Place Poster Award: July, 2022 at International Conference in Costa Rica

> > 🏆 First Place Poster Award: March, 2023 at University-wide symposium

> > 📖 Date Published: May 26, 2023

## Where:

> > 📓 Data collected in: Lincoln, Nebraska

> > 📖 Data published in: *Urban Ecosystems*

## Why:

> > Animals distribute themselves within habitats based on a variety of environmental conditions, including those impacted by urbanization. Suspected global declines in urban arthropod biodiversity have required that we examine how urban conditions affect the distribution of this ecologically important group. Traffic impacts and road presence likely introduce vibrations to the ground that could disrupt vibratory information acquisition, potentially leading urban spiders to adjust their location to minimize noise impacts. The use of vibratory information is widespread among many urban-dwelling arthropods, and future research is needed to determine if vibratory noise could play a role in the global decline of urban arthropod biodiversity.

## How:

> > 💻 R programming language

Analyses include:

-   Correlation analysis ([2_transformations_reductions.Rmd](./2_transformations_reductions.Rmd))
-   Negative binomial generalized linear models and mixed-effect models ([3_habitat_characteristics_nb.Rmd](./3_habitat_characteristics_nb.Rmd), [4_spider_measurements_nb.Rmd](./4_spider_measurements_nb.Rmd))
-   Post-hoc multiple comparisons ([6_land_cover_posthoc_nb.Rmd](./6_land_cover_posthoc_nb.Rmd))
-   Akaike Information Criterion (AIC) model selection ([5_environmental_aic_selection.Rmd](./5_environmental_aic_selection.Rmd))

> > 🗺️ QGIS geographic information system software
