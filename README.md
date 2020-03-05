# setup env

```console
conda create -y -n lpy3 -c fredboudon -c conda-forge openalea.lpy openalea.mtg r
conda activate lpy3
```

# build V-Mango

dev version - use imports from source tree

```console
python setup.py develop
```

use imports from openalea.vmango site package

```console
python setup.py install
```

# run V-Mango in lpy gui
```console
lpy
```
* open src\openalea\vmango\simulation\mango_simulation.lpy in lpy
* click 'Rewind'
* click 'Run'

# run V-Mango 'headless'

```console
cd src\openalea\vmango\simulation
ipython
%gui qt5
%run runsimu.py
```

# jupyter

```console
conda create -n jupyter -y -c fredboudon -c conda-forge openalea.lpy openalea.mtg r jupyterlab
```