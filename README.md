# MushR

MushR is a modular and scalable gourmet mushroom growing and
harvesting system that goes beyond the state of the art, which merely
monitors and controls the growing environment, by introducing an image
recognition system that determines when and which mushrooms are ready
to be harvested in conjunction with a proof-of-concept of an automated
mushroom harvesting mechanism for harvesting the mushrooms without
human interaction. The image recognition setup monitors the growing
status of the mushrooms and guides the harvesting process. We present
a Mask R-CNN model for the detection of oyster mushroom maturity as
well as a semi-automated harvesting system, integrating a Raspberry Pi
for control, an electrical switch, an air compressor, and a pneumatic
cylinder with a cutting knife to facilitate timely mushroom
harvesting. The modularity and scalability of the system allow for
industry-level usage and can be scaled according to the required
mushroom-growing systems within the facility.

The dataset created for this project focuses on capturing images of
the mushroom-growing environment from three different perspectives
within each of our two growth tents for mushroom production. Instead
of providing images of every individual bucket and mushroom, we
capture the overall scene and its variations. The images from each
perspective are captured simultaneously and automatically hourly. This
approach allows for monitoring the development and maturity of the
oyster mushrooms over time. We captured and accumulated 34,400 images
over ten months to ensure a comprehensive dataset.


- [Growchamber Setup](growchamber-setup/)
- [Automated Image Capture](automated-image-capture/) 

- [Lifecycle Assessment Calculations](lca-calculations/)
- MushR Digital Twin
  - [MushR Digital Twin API](https://github.com/ETCE-LAB/mushr-digitaltwin-api/tree/main)
  - [MushR Digital Twin Widgets for MyCodo](https://github.com/ETCE-LAB/mushr-digitaltwin-api/tree/main/mycodo)
- MushR Dataset
  - [Complete Un-Annotated RAW Images](https://www.kaggle.com/datasets/etcelab/mushr-project-raw-image-dataset-oyster-mushrooms)
  - [MushR Mask R CNN](https://github.com/ETCE-LAB/mushr-mask-r-cnn)
- Harvesting Setup
 - [Pneumatic Harvesting](pneumatic-harvesting/)
 - [Motorized Harvesting](motorized-harvesting/)

# Contributors (Past and Present)

1. Anant Sujatanagarjuna
2. Shohreh Kia
3. Harish Gundelli
