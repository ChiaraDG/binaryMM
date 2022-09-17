# binaryMM: Fitting Flexible Marginalized Models for Binary Correlated Outcomes

The `binaryMM` package allows users to fit marginalized transition and latent variables (mTLV) models for binary correlated data. You can install the development version from GitHub with:

```{r, eval = FALSE}
install.packages("devtools")
devtools::install_github("ChiaraDG/binaryMM")
```

## Examples

### Fitting and Comparing Marginalized Models

The function `mm` allows users to fit marginalized models with a transition and/or a latent term. Users specify the marginal mean model with `mean.formula`, the transition component of the dependence model with `t.formula` and the latent variable component of the dependence model with `lv.formula`. The model below specifies both a transition and a latent variable term in the dependence model:

```{r}
mod.mtlv <- mm(mean.formula = thought ~ month*gender + month*age,
               t.formula = ~1, lv.formula = ~1, 
               data = madras, id = id)
summary(mod.mtlv)
```

User can speficy a dependence model with a transition term only with the code below:

```{r, eval = FALSE}
mod.mt <- mm(mean.formula = thought ~ month*gender + month*age,
               t.formula = ~1, lv.formula = NULL, 
               data = madras, id = id)
summary(mod.mt)
```

### Generate Outcome Data under a Marginalized Model


