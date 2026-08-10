# Umlauf Orbit Simulator (UOS)

## Description

**Umlauf Orbit Simulator (UOS)** is a GNU Octave-based satellite orbit simulation and visualisation program.

The name **Umlauf** comes from German and means **revolution** or **circulation**, referring to the motion of a satellite around Earth.

UOS allows users to define a satellite using classical orbital elements and simulate its motion around Earth while accounting for:

* Newtonian gravity
* Earth's J2 gravitational perturbation
* Atmospheric drag

The simulator also provides a 3D orbit animation, altitude and speed graphs, and basic orbital information.

---

## Features

* 3D animated satellite orbit
* Classical orbital element input
* Newtonian gravitational acceleration
* Earth's J2 gravitational perturbation
* Atmospheric drag modelling
* Altitude-dependent atmospheric density
* Altitude vs time graph
* Speed vs time graph
* Orbital period calculation
* Semi-major axis calculation
* Eccentricity calculation
* Maximum and minimum altitude calculation
* Option to independently enable or disable drag and J2 effects

---

## Built With

* **GNU Octave**
* MATLAB-compatible syntax
* Octave GUI tools
* Matrix and vector operations
* CSV atmospheric-density data
* 3D plotting and animation

---

## Physics Model

### Newtonian Gravity

The primary acceleration acting on the satellite is Earth's gravitational attraction:

```text
a = -(μ/r³)r
```

where:

* `μ` is Earth's gravitational parameter
* `r` is the satellite's position vector
* `r` is the distance of the satellite from Earth's centre

UOS uses:

```text
μ = 398600.11 × 10⁹ m³/s²
```

---

### Earth's J2 Perturbation

Earth is not a perfect sphere. Its equatorial bulge causes small variations in the gravitational field experienced by an orbiting satellite.

UOS models this using Earth's J2 coefficient:

```text
J2 = 1.08263 × 10⁻³
```

The J2 perturbation can be enabled or disabled from the graphical interface.

---

### Atmospheric Drag

Atmospheric drag is modelled using:

```text
a_drag = -0.5 × Cd × ρ × (A/m) × |v| × v
```

where:

* `Cd` = drag coefficient
* `ρ` = atmospheric density
* `A` = satellite cross-sectional area
* `m` = satellite mass
* `v` = satellite velocity vector

The simulator calculates the satellite's altitude and obtains the corresponding atmospheric density from an external CSV dataset.

Linear interpolation is used when the exact altitude is not present in the dataset.

Atmospheric drag can be enabled or disabled from the graphical interface.

---

## Orbital Elements

UOS accepts six classical orbital elements:

1. **Semi-major Axis**
2. **Eccentricity**
3. **Inclination**
4. **Right Ascension of the Ascending Node (RAAN)**
5. **Argument of Perigee**
6. **True Anomaly**

These orbital elements are converted into three-dimensional position and velocity vectors before the orbit propagation begins.

---

## Orbit Propagation

The simulator calculates the total acceleration acting on the satellite at each time step.

The velocity is updated using:

```text
v(k) = v(k-1) + aΔt
```

The position is then updated using:

```text
r(k) = r(k-1) + v(k)Δt
```

This allows the satellite trajectory to be calculated step by step over the selected simulation period.

---

## Installation

### 1. Install GNU Octave

Download and install GNU Octave for your operating system.

### 2. Download UOS

Download or clone this repository.

Keep the following files inside the same folder:

```text
Umlauf-Orbit-Simulator/
│
├── satellite_gui.m
├── elements_to_posi_vel.m
├── alt_density_pratham.csv
├── README.md
└── LICENSE
```

### 3. Open the Project Folder

Launch GNU Octave.

Set the current working directory to the folder containing the UOS files.

---

## Usage

Run the following command in the GNU Octave command window:

```matlab
satellite_gui
```

The Umlauf Orbit Simulator graphical interface will open.

---

## Input Parameters

### Satellite Properties

#### Area (m²)

The effective cross-sectional area of the satellite.

This value is used in the atmospheric drag calculation.

#### Mass (kg)

The mass of the satellite.

#### Drag Coefficient

A dimensionless coefficient representing the aerodynamic drag characteristics of the satellite.

---

### Orbital Parameters

#### Semi-major Axis (m)

Defines the overall size of the orbit.

The value must be entered in metres.

#### Eccentricity

Defines the shape of the orbit.

```text
e = 0        Circular orbit
0 < e < 1    Elliptical orbit
```

#### Inclination (deg)

Defines the angle between the orbital plane and Earth's equatorial plane.

#### RAAN (deg)

RAAN stands for **Right Ascension of the Ascending Node**.

It defines the orientation of the orbital plane around Earth.

#### Argument of Perigee (deg)

Defines the orientation of the elliptical orbit within its orbital plane.

#### True Anomaly (deg)

Defines the satellite's initial position within its orbit.

---

### Simulation Parameters

#### No. of Orbits

Defines how many orbital periods will be simulated.

#### Time Step

Defines the time interval between numerical calculations.

A smaller time step generally provides a more detailed numerical simulation but requires more calculations.

---

## Optional Effects

### Enable Drag

When enabled, atmospheric drag is added to the satellite's acceleration.

When disabled, the atmospheric drag force is ignored.

### Enable J2

When enabled, Earth's J2 gravitational perturbation is added to the simulation.

When disabled, Earth is treated more closely as a spherically symmetric gravitational body.

The two effects can be independently enabled or disabled.

---

## Running a Simulation

1. Start GNU Octave.
2. Open the UOS project directory.
3. Run:

```matlab
satellite_gui
```

4. Enter the satellite properties.
5. Enter the six orbital elements.
6. Select the number of orbits.
7. Set the simulation time step.
8. Enable or disable atmospheric drag.
9. Enable or disable J2.
10. Click **Run Simulation**.

The simulator will calculate and display the satellite trajectory.

---

## Outputs

### 3D Satellite Orbit

The main display shows Earth and the satellite's three-dimensional trajectory.

The satellite position is animated as the orbit progresses.

---

### Altitude vs Time

Displays the satellite's altitude above Earth's surface throughout the simulation.

Altitude is displayed in kilometres.

---

### Speed vs Time

Displays the magnitude of the satellite's velocity throughout the simulation.

Speed is displayed in kilometres per second.

---

### Orbital Information

After the simulation runs, UOS displays:

* Orbital period
* Semi-major axis
* Eccentricity
* Maximum altitude
* Minimum altitude

---

## Default Simulation Values

The simulator includes the following default values:

```text
Area                 = 5 m²
Mass                 = 25 kg
Drag Coefficient     = 2

Semi-major Axis      = 7,000,000 m
Eccentricity         = 0.001
Inclination          = 45°
RAAN                 = 45°
Argument of Perigee  = 45°
True Anomaly         = 45°

Number of Orbits     = 5
Time Step            = 1 second

Atmospheric Drag     = Enabled
J2                   = Enabled
```

These values can be changed before running the simulation.

---

## Atmospheric Density Data

UOS uses the following external file:

```text
alt_density_pratham.csv
```

The file contains atmospheric density values corresponding to different altitudes.

The simulator calculates the current satellite altitude and uses linear interpolation to estimate the atmospheric density at that altitude.

The CSV file must remain in the same working directory as the simulator unless the source code is modified to use another path.

---

## Model Limitations

UOS is intended as an educational orbital-mechanics and numerical-simulation project rather than a professional mission-analysis system.

The current model does not include:

* Solar radiation pressure
* Solar gravitational perturbations
* Lunar gravitational perturbations
* Atmospheric rotation
* Satellite thrust
* Orbital manoeuvres
* Higher-order gravitational harmonics
* Relativistic effects
* Satellite attitude changes
* Changes in spacecraft mass
* Changes in spacecraft geometry

The numerical propagation method is also simpler than high-precision integration methods used in professional orbital-analysis software.

---

## Troubleshooting

### Atmospheric Density File Not Found

Make sure the following file exists in the same working directory:

```text
alt_density_pratham.csv
```

---

### Simulator Does Not Start

Confirm that the following files are present:

```text
satellite_gui.m
elements_to_posi_vel.m
alt_density_pratham.csv
```

Then run:

```matlab
satellite_gui
```

---

### Unexpected Orbit

Check that:

* Semi-major axis is entered in metres.
* Angles are entered in degrees.
* Mass is greater than zero.
* Area is not negative.
* Time step is greater than zero.
* Number of orbits is greater than zero.
* Eccentricity is between `0` and `1` for an elliptical orbit.

---

### Simulation Is Too Slow

Try:

* Reducing the number of simulated orbits.
* Increasing the time step.

Increasing the time step reduces the number of calculations but may also reduce numerical accuracy.

---

## Project Structure

```text
Umlauf-Orbit-Simulator/
│
├── satellite_gui.m
│   └── Main GUI, orbit propagation, perturbation modelling and visualisation
│
├── elements_to_posi_vel.m
│   └── Converts classical orbital elements into position and velocity vectors
│
├── alt_density_pratham.csv
│   └── Atmospheric density data
│
├── README.md
│   └── Project documentation and user manual
│
└── LICENSE
    └── Academic Free License 3.0
```

---

## Possible Future Improvements

Potential improvements to UOS include:

* Runge-Kutta orbit propagation
* Higher-accuracy numerical integration
* Solar gravitational perturbations
* Lunar gravitational perturbations
* Solar radiation pressure
* Improved atmospheric models
* Atmospheric rotation
* Ground-track visualisation
* Orbital-element evolution graphs
* Data export
* Multiple satellite simulation
* Satellite manoeuvre modelling
* Improved graphical interface
* Real satellite orbital data input

---

## Contributing

Contributions, improvements and bug reports are welcome.

To contribute:

1. Fork this repository.
2. Create a new branch for your changes.
3. Make the required modifications.
4. Test the simulator.
5. Clearly describe your changes.
6. Submit a pull request.

For bug reports, include:

* Input parameters used
* Expected behaviour
* Observed behaviour
* GNU Octave version
* Any error messages generated

---

## Author

**Pratham Vohra**

Umlauf Orbit Simulator was developed as an independent orbital-mechanics, physics and numerical-simulation project.

---

## License

**Umlauf Orbit Simulator (UOS)**

Copyright © 2026 Pratham Vohra

Licensed under the **Academic Free License version 3.0 (AFL-3.0)**.

See the `LICENSE` file included in this repository for the complete license terms.

```text
SPDX-License-Identifier: AFL-3.0
```

---

## Project Name

**Umlauf Orbit Simulator**

**Abbreviation:** UOS

**Umlauf:** German for *revolution* or *circulation*, representing the orbital motion simulated by the program.
