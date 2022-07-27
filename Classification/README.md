# Classification

## The idea

This will be composed of 3 layers

### Layer one

- One hybrid layer that will prioritize detecting the absence of animals at all (80% of the problem) 
  - Movement detection: Lucas-Kanade based solution. Julia.
  - Object detection: CNN based solution. Python, Tensorflow. It shall be a generic model that will detect any animal. We will focus on it's true negatives.

### Layer two
- The main model that will classify the native species, cows and even dogs (this will solve a little more than 15% of the problem)
### Layer three
- One tiny model that will classify the species of foxes, which are common appearances in the datasets

## Tools 

- Python 3.9
- Tensorflow 2.9.1 and its Object Detection 1.0 API.
- Julia, any version is fine because there is no dependency hell as in python.

## Pre-Trained Model

  - EfficientDet D7 1536x1536