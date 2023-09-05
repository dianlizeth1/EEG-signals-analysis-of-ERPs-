# EEG Signal Analysis of ERPs
In this code, we will analyze evoked and induced neural activity in response to events that elicit emotional responses in autistic children, based on the data from the following article: [Link to the article](https://www.sciencedirect.com/science/article/pii/S2352340923001750#tbl0002). You can download the data file named "PartXX_scenarioXX_4disc.gdf."

## Signal Preprocessing
First, we need to preprocess the EEG signals using EEGlab. We will filter the EEG signals in the alpha, beta, and gamma frequency bands (30-50Hz) and segment them in time according to events involving emotional induction (0-300ms).

## 1. Evoked Analysis
After establishing the time window (0-300ms) during signal preprocessing, we will estimate Event-Related Potentials (ERPs) for all events that induce emotional responses in autistic children. We will plot these ERPs in a 5x5 figure. For each ERP, we will calculate the average amplitude and display the signal-to-noise ratio in a subplot for each channel.

## 2. Induced Analysis
We will identify the channel with the highest maximum amplitude and estimate its Event-Related Desynchronization/Event-Related Synchronization (ERD/ERS) map in decibels. Additionally, we will identify the channel with the lowest average amplitude and estimate its ERD/ERS map in decibels. We will then create a graph displaying the channel with the highest average amplitude at the top and the channel with the lowest average amplitude at the bottom. Finally, we will subtract the ERD/ERS maps of these two channels from each other. This subtraction will reveal the largest differences in time and frequency in contrast to the original map.
