# helx-hail

### Build
```
bin/comp build jdk-layer
bin/comp push jdk-layer
bin/comp build conda-layer
bin/comp push conda-layer
bin/comp build helx-hail
bin/comp push helx-hail
```

### Run
```
docker run --rm --name helx-hail -p 8000:8000 heliumdatastage/helx-hail
```
Start a Hail-Python3 notebook and run:
```
import hail as hl
mt = hl.balding_nichols_model(n_populations=3, n_samples=50, n_variants=100)
mt.count()
```
![image](https://user-images.githubusercontent.com/306971/61135288-51bb0380-a48f-11e9-86fb-588d90100e19.png)
