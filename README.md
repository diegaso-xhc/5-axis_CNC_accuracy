# Calculate the accuracy of 5-axis CNCs

## Overview of the repostitory
<div align="justify">
Five axis CNCs are essential for the manufacturing of highly complex mechanical parts. In some applications, such as aerospace industry, the low error tolerances for the dimensions of a mechanical part, requires an extremely high accuracy on the manufacturing CNCs. 

<br />

A common measurement of the accuracy of a five axis CNC is the circularity of the outter circle of a cone frustum tilted in space. After the CNC being evaluated finishes the material remotion from this cone frustum, precision tools are used to sample points around its circumference. However, extracting the circularity values of this points set is not trivial as the number of points, positions, among other parameters, change depending on the control parameters of the machine, the operator using the measurement tool, etc. 

<br />

This repository shows a Matlab implementation of an algorithm customized for the circularity measurements of five axis CNC via manufacturing of a cone frustum.
<br />
<br /> 

<p align="center">
   <img src="/Visualizations/Circularity_plot.png" width="700" />
</p>

<br />

## Understanding repository

The repository consists of a versatile toolbox to handle objects in space using concepts of linear algebra. Machine learning concepts such as gradient descent methods in combination with normal distributions concepts were implemented to robustly return the circularity value under different conditions. These algorithms were validated in cooperation with the <a href="https://www.itri.org.tw/english/ListStyle.aspx?DisplayStyle=20&SiteID=1&MmmID=617731521661672477">Industrial Technology Research Institute of Taiwan</a>.

<br />

Additionally all functions within the repository were written so they can be easily translated into other languages, such as c++, c#, python. Therefore, proprietary functions have only been included for visualization.

<br />
<br />

## Contributions

The contributions of this repository can be summarized as follows:

```
- Algorithms written in translatable code to handle vectors in space.
- Algorithms using machine learning to calculate the circularity of a set of points taken from a manufactured cone frustum.
- Visualization tools for the tool path in space.
```

## License

Developed by Diego Hidalgo C. (2021). This repository is intended for research purposes only. If you wish to use any parts of the provided code for commercial purposes, please contact the author at hidalgocdiego@gmail.com.
