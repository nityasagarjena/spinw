---
{title: sw_egrid( ), link: sw_egrid, summary: creates energy for spectrum color plot,
  keywords: sample, sidebar: sw_sidebar, permalink: sw_egrid.html, folder: swfiles,
  mathjax: 'true'}

---

### Syntax

` `

### Description

function component(s) binned in energy using the grid.
 

### Examples

spectra = sw_egrid(spectra,'component',{'Sxx+Syy' 'Szz'},'Evect',linspace(0,5,51));
The line will create an energy bin, with steps of 0.1 and bins the
spin-spin correlation function. Two different matrices will be
calculated, first using the sum of the Sxx and Syy components, second
will contain the Szz component of the correlation function.

### Input Arguments

% `spectra`
: Input structure, contains calculated correlation functions.

### Name-Value Pair Arguments

% `component`
:nt Selects which correlation function component to be binned in

% `energy.`
: The possible options are:
 erp' bins the magnetic neutron scattering intensity
      (<Sperp * Sperp> expectation value).
      Default.
 b'   bins the selected components of the spin-spin
      correlation function. Letter a and b can be 'x',
      'y' or 'z'. For example: 'Sxx' will convolute the
      xx component of the correlation function with the
      dispersion. xyz is the standard coordinate system,
      see online documentation of spinw.
 b'   bins the selected components of the spin-spin
      correlation function. Letter a and b can be 'x',
      'y' or 'z'. For example: 'Mxx' will convolute the
      xx component of the correlation function with the
      dispersion. The coordinates here are in the
      Blume-Maleev coordinate system, see below.
 b'   bins the selected element of the polarisation
      matrix. Letter a and b can be 'x', 'y' or 'z'. For
      example: 'Pyy' will convolute the yy component of
      the polarisation matrix with the dispersion. The
      coordinates used are in the Blume-Maleev coordinate
      system, see below.
 '    bins the intensity of the simulated polarised
      neutron scattering, with inciden polarisation of
      Pa. Letter a can be 'x', 'y' or 'z'. For example:
      'Py' will convolute the scattering intensity
      simulated for incident polarisation Pi || y. The
      used coordinates are in the Blume-Maleev coordinate
      system, see below.
 ame' where fName is one of the field names of the input
      structure spectra. This field should contain a
      matrix with size [nMode nHkl].

% `Any`
:ear combination of the above are allowed, for example:

% `'Sxx+2*Syy'`
:Syy' bins the linear combination of the xx component of

% `the`
:n-spin correlation function with the yy component.

% `Several`
: cross section can be convoluted and stored

% `independently,`
:dently, if component is a cell array containing strings

% `each`
:ntaining any linear combination of cross sections as

% `above,`
:the cell array needs to have size [1 nCell].

% `Evect`
:   Vector, defines the center/edge of the energy bins of the

% `calculated`
:ted output, dimensions are is [1 nE]. The energy units

% `are`
:ined by the unit.kB property of the spinw object. Default

% `value`
:s an edge bin: linspace(0,1.1*maxOmega,501).

% `binType`
:   String, determines the type of bin give, possible options:
 in'    Center bin, the center of each energy bin is given.
 in'    Edge bin, the edges of each bin is given.

% `Default`
: is 'ebin'.

% `T`
:   Temperature, used to calculate the Bose factor in units

% `depending`
:ng on the Boltzmann constant (spinw.unit.kB). Default

% `temperature`
:ture is taken from obj.single_ion.T. The Bose factor is

% `included`
:d in swConv field of the output.

% `sumtwin`
:   If true, the spectra of the different twins will be summed

% `together`
:r weighted with the normalized volume fractions. Default

% `is`
:.

% `modeIdx`
:   Select certain spin wave modes from the 2*nMagAtom number of

% `modes`
:o include in the output. Default is 1:2*nMagAtom to

% `include`
: all modes.

% `epsilon`
:   Error limit, used to determine whether a given energy bin is

% `uniform`
: or not. Default is 1e-5.

% `autoEmin`
:n  Due to the finite numerical precision, the spin wave energies

% `can`
:tain small imaginary energies. These can ruin the

% `convoluted`
:ted spectrum at low energies. To improve the spectrum,

% `the`
:est energy bin should start above the imaginary part of

% `the`
:n wave energy. If 'autoEmin' is set to true, it

% `calculates`
:tes the bottom of the first energy bin automatically and

% `overwrites`
:tes the given value. Only works if the input energy bin

% `starts`
:with zero. Default is false.

% `imagChk`
:   Checks that the imaginary part of the spin wave dispersion is

% `smaller`
: than the energy bin size. Default is true.

% `The`
:me-Maleev coordinate system is a cartesian coordinate system

% `with`
:BM, yBM and zBM) basis vectors as follows:

% `xBM`
:parallel to the momentum transfer Q,

% `yBM`
:perpendicular to xBM in the scattering plane,

% `zBM`
:perpendicular to the scattering plane.

### Output Arguments

spectra contains the following additional fields beside the input:
swConv    Stores the selected cross section binned along energy, size is
[nE nHkl]. Includes the Bose factor.
swInt     Stores the selected cross sections for every mode, size is
[nMode nHkl].
T         Input temperature.
component Cell that contains the input component selector strings.
Evect     Input energy bin vector, defines the energy bin edge positions
(converted from the given bin centers if necessary).
param     All the other input parameters.
If 'component' parameter is a cell array or the spectra of multiple
twins are convoluted separately, swConv and swInt will be packaged into
a cell. The dimensions of the cell are [nConv nTwin].

### See Also

[spinw.spinwave](spinw_spinwave.html) and [sw_neutron](sw_neutron.html)
