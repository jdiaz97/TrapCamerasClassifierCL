# Modelling

## The idea

This will be composed of 3 models, stacked in layers that will activate depending on the outputs of the previous layer.

- One tiny model that will detect the presence of any animal (the true negatives will solve around ~80% of the problem)
- The main model that will classify the native species, cows and even dogs (this will solve a little more than 15% of the problem)
- One tiny model that will classify the species of foxes, which are common appearances in the datasets

## Tools 

- Python 3.9
- Tensorflow 2.9.1 and its Object Detection 1.0 API.

## Pre-Trained Model

  - EfficientDet D7 1536x1536