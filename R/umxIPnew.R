#' umxIP: Build and run an Independent pathway twin model
#'
#' Make a 2-group Independent Pathway twin model (Common-factor independent-pathway multivariate model).
#' The following figure shows the IP model diagrammatically:
#'
#' \if{html}{\figure{IP.png}{options: width="50\%" alt="Figure: IP.png"}}
#' \if{latex}{\figure{IP.pdf}{options: width=7cm}}
#'
#' As can be seen, each phenotype also by default has A, C, and E influences specific to that phenotype.
#' 
#' Features of the model include the ability to include add more one set of independent pathways, different numbers
#' of pathways for a, c, and e, as well the ability to use ordinal data, and different fit functions, e.g. WLS.
#' 
#' **note**: The function `umx_set_optimization_options`() allow users to see and set `mvnRelEps` and `mvnMaxPointsA`
#' It defaults to .001. You might find that '0.01' works better for ordinal models.
#' 
#' @details
#' Like the \code{\link{umxACE}} model, the CP model decomposes phenotypic variance
#' into Additive genetic, unique environmental (E) and, optionally, either
#' common or shared-environment (C) or 
#' non-additive genetic effects (D).
#' 
#' Unlike the Cholesky, these factors do not act directly on the phenotype. Instead latent A, 
#' C, and E influences impact on one or more latent common factors which, in turn, account for 
#' variance in the phenotypes (see Figure).
#' 
#' 
#' **Data Input**
#' Currently, `umxIP` accepts only raw data. This may change in future versions. You can
#' choose other fit functions, e.g. WLS.
#' 
#' **Ordinal Data**
#' 
#' In an important capability, the model transparently handles ordinal (binary or multi-level
#' ordered factor data) inputs, and can handle mixtures of continuous, binary, and ordinal
#' data in any combination.
#' 
#' **Additional features**
#' 
#' `umxIP` supports varying the DZ genetic association (defaulting to .5)
#' to allow exploring assortative mating effects, as well as varying the DZ \dQuote{C} factor
#' from 1 (the default for modeling family-level effects shared 100% by twins in a pair),
#' to .25 to model dominance effects.
#'
#' **Matrices and Labels in CP model**
#' 
#' A good way to see which matrices are used in umxIP is to run an example model and plot it.
#'
#' All the shared matrices are in the model "top".
#' 
#' Matrices `as`, `cs`, and `es` contain the path loadings specific to each variable on their diagonals.
#' 
#' To see the 'as' values, you can simply execute:
#'
#' m1$top#as$values
#' 
#' m1$top#as$labels
#' 
#' m1$top#as$free
#' 
#' Labels relevant to modifying the specific loadings take the form "as_r1c1", "as_r2c2" etc.
#' 
#' The independent-pathway loadings on the manifests are in matrices `a_ip`, `c_ip`, `e_ip`.
#'	
#' Less commonly-modified matrices are the mean matrix `expMean`. This has 1 row, and the columns are laid 
#' out for each variable for twin 1, followed by each variable for twin 2.
#' So, in a model where the means for twin 1 and twin 2 had been equated (set = to T1), you could make them independent again with this script:
#'
#' `m1$top$expMean$labels[1,4:6] =  c("expMean_r1c4", "expMean_r1c5", "expMean_r1c6")`
#'
#' @param name The name of the model (defaults to "IP").
#' @param selDVs The variables to include.
#' @param dzData The DZ dataframe.
#' @param mzData The MZ dataframe.
#' @param sep The suffix for twin 1 and twin 2, often "_T". If set, you can omit suffixes in selDVs, i.e., just "dep" not c("dep_T1", "dep_T2").
#' @param nFac How many common factors for a, c, and e. If 1 number number is given, applies to all three.
#' @param type Analysis method one of c("Auto", "FIML", "cov", "cor", "WLS", "DWLS", "ULS")
#' @param weightVar If provided, a vector objective will be used to weight the data. (default = NULL).
#' @param bVector Whether to compute row-wise likelihoods (defaults to FALSE).
#' @param thresholds How to implement ordinal thresholds c("deviationBased").
#' @param equateMeans Whether to equate the means across twins (defaults to TRUE).
#' @param dzAr The DZ genetic correlation (defaults to .5, vary to examine assortative mating).
#' @param dzCr The DZ "C" correlation (defaults to 1: set to .25 to make an ADE model).
#' @param correlatedA Whether factors are allowed to correlate (not implemented yet: FALSE).
#' @param addStd Whether to add the algebras to compute a std model (defaults to TRUE).
#' @param addCI Whether to add the interval requests for CIs (defaults to TRUE).
#' @param numObsDZ = TODO: implement ordinal Number of DZ twins: Set this if you input covariance data,
#' @param numObsMZ = TODO: implement ordinal Number of MZ twins: Set this if you input covariance data.
#' @param autoRun Whether to run the model, and return that (default), or just to create it and return without running.
#' @param tryHard optionally tryHard (default 'no' uses normal mxRun). c("no", "mxTryHard", "mxTryHardOrdinal", "mxTryHardWideSearch")
#' @param optimizer optionally set the optimizer (default NULL does nothing).
#' @param freeLowerA Whether to leave the lower triangle of A free (default = FALSE).
#' @param freeLowerC Whether to leave the lower triangle of C free (default = FALSE).
#' @param freeLowerE Whether to leave the lower triangle of E free (default = FALSE).
#' @return - \code{\link{mxModel}}
#' @export
#' @family Twin Modeling Functions
#' @seealso - \code{\link{plot}()}, \code{\link{umxSummary}()} work for IP, CP, GxE, SAT, and ACE models.
#' @references - \url{https://www.github.com/tbates/umx}
#' @md
#' @examples
#' \dontrun{
#' require(umx)
#' data(GFF)
#' mzData <- subset(GFF, zyg_2grp == "MZ")
#' dzData <- subset(GFF, zyg_2grp == "DZ")
#' selDVs = c("gff","fc","qol","hap","sat","AD") # These will be expanded into "gff_T1" "gff_T2" etc.
#' m1 = umxIPnew(selDVs = selDVs, sep = "_T", dzData = dzData, mzData = mzData)
#' m1 = umxIPnew(selDVs = selDVs, sep = "_T", dzData = dzData, mzData = mzData, 
#' 	nFac = c(a = 3, c = 1, e = 1)
#' )
#' umxSummary(m1)
#' plot(m1)
#' }
umxIPnew <- function(name = "IP", selDVs, dzData, mzData, sep = NULL, nFac = c(a=1, c=1, e=1), type = c("Auto", "FIML", "cov", "cor", "WLS", "DWLS", "ULS"), weightVar = NULL, equateMeans = TRUE, bVector = FALSE, thresholds = c("deviationBased"), dzAr = .5, dzCr = 1, correlatedA = FALSE, addStd = TRUE, addCI = TRUE, numObsDZ = NULL, numObsMZ = NULL, autoRun = getOption("umx_auto_run"), tryHard = c("no", "mxTryHard", "mxTryHardOrdinal", "mxTryHardWideSearch"), optimizer = NULL, freeLowerA = FALSE, freeLowerC = FALSE, freeLowerE = FALSE) {
	# TODO implement correlatedA
	if(correlatedA){
		message("I have not implemented correlatedA yet...")
	}
	nSib = 2 # Number of siblings in a twin pair.
	thresholds = match.arg(thresholds)
	type = match.arg(type)
	# covMethod  = match.arg(covMethod)

	# TODO umxIPnew: check covs
	xmu_twin_check(selDVs= selDVs, sep = sep, dzData = dzData, mzData = mzData, enforceSep = FALSE, nSib = nSib, optimizer = optimizer)

	if(length(nFac) == 1){
		nFac = c(a = nFac, c = nFac, e = nFac)
	} else if (length(nFac) != 3){
		stop("nFac must be either 1 number or 3. You gave me ", length(nFac))
	}
	if(dzCr == .25 & (name == "IP")){
		name = "IP_ADE"
	}else if(name == "IP"){
		# Add nFac to base name if no user-set name provided.
		if (length(nFac) == 1){
			name = paste0(name, nFac, "fac")
		}else{
			name = paste0(name, paste0(c("a", "c", "e"), nFac, collapse = ""))
		}
	}

	# Expand var names if necessary
	if(!is.null(sep)){
		selVars = tvars(selDVs, sep = sep, suffixes = 1:nSib)
	}else{
		selVars = selDVs
	}
	nVar = length(selVars)/nSib; # Number of dependent variables per **INDIVIDUAL** (so x2 per family)

	bits = xmu_make_top_twin_models(mzData = mzData, dzData = dzData, selDVs= selDVs, sep = sep, equateMeans = equateMeans,
					type = type, numObsMZ = numObsMZ, numObsDZ = numObsDZ, weightVar = weightVar, bVector = bVector)
	top     = bits$top
	MZ      = bits$MZ
	DZ      = bits$DZ

	if(bVector){
		mzWeightMatrix = bits$mzWeightMatrix
		dzWeightMatrix = bits$dzWeightMatrix
	}else{
		mzWeightMatrix = dzWeightMatrix = NULL
	}

	# Define varStarts ...
	tmp = xmu_starts(mzData, dzData, selVars = selDVs, sep = sep, nSib = nSib, varForm = "Cholesky", equateMeans= equateMeans, SD= TRUE, divideBy = 3)
	varStarts = tmp$varStarts

	# TODO: umxIP improve start values (hard coded at std type values)
	top = mxModel(top,
		# "top" defines the algebra of the twin model, which MZ and DZ slave off of
		# NB: top already has the means model and thresholds matrix added if necessary  - see above
		# Additive, Common, and Unique environmental paths
		# Matrices ai, ci, and ec, to store a, c, and e path coefficients for independent general factors
		umxMatrix("ai", "Full", nVar, nFac['a'], free = TRUE, values = .6, jiggle = .05), # latent common factor Additive genetic path 
		umxMatrix("ci", "Full", nVar, nFac['c'], free = TRUE, values = .0, jiggle = .05), # latent common factor Common #environmental path coefficient
		umxMatrix("ei", "Full", nVar, nFac['e'], free = TRUE, values = .6, jiggle = .05), # latent common factor Unique environmental path #coefficient
		# Matrices as, cs, and es, to store a, c, and e path coefficients for specific factors
		umxMatrix("as", "Lower", nVar, nVar, free = TRUE, values = .6, jiggle = .05), # Additive genetic path 
		umxMatrix("cs", "Lower", nVar, nVar, free = TRUE, values = .0, jiggle = .05), # Common environmental path 
		umxMatrix("es", "Lower", nVar, nVar, free = TRUE, values = .6, jiggle = .05), # Unique environmental path.

		umxMatrix("dzAr", "Full", 1, 1, free = FALSE, values = dzAr),
		umxMatrix("dzCr", "Full", 1, 1, free = FALSE, values = dzCr),

		# Multiply by each path coefficient by its inverse to get variance component
		# Sum the squared independent and specific paths to get total variance in each component
		mxAlgebra(name = "A", ai%*%t(ai) + as%*%t(as) ), # Additive genetic variance
		mxAlgebra(name = "C", ci%*%t(ci) + cs%*%t(cs) ), # Common environmental variance
		mxAlgebra(name = "E", ei%*%t(ei) + es%*%t(es) ), # Unique environmental variance

		mxAlgebra(name = "ACE", A+C+E),
		mxAlgebra(name = "AC" , A+C  ),
		mxAlgebra(name = "hAC", (dzAr %x% A) + (dzCr %x% C)),
		mxAlgebra(rbind (cbind(ACE, AC), 
		                 cbind(AC , ACE)), dimnames = list(selDVs, selDVs), name = "expCovMZ"),
		mxAlgebra(rbind (cbind(ACE, hAC),
		                 cbind(hAC, ACE)), dimnames = list(selDVs, selDVs), name = "expCovDZ"),

		# Algebra to compute total variances and standard deviations (diagonal only)
		mxMatrix("Iden", nrow = nVar, name = "I"),
		mxAlgebra(solve(sqrt(I * ACE)), name = "iSD")
	)

	# =====================================
	# =  Assemble models into supermodel  =
	# =====================================
	model = xmu_assemble_twin_supermodel(name, MZ, DZ, top, bVector, mzWeightMatrix, dzWeightMatrix)

	if(!freeLowerA){
		toset  = model$top$matrices$as$labels[lower.tri(model$top$matrices$as$labels)]
		model = omxSetParameters(model, labels = toset, free = FALSE, values = 0)
	}

	if(!freeLowerC){
		toset  = model$top$matrices$cs$labels[lower.tri(model$top$matrices$cs$labels)]
		model = omxSetParameters(model, labels = toset, free = FALSE, values = 0)
	}
	
	if(!freeLowerE){
		toset  = model$top$matrices$es$labels[lower.tri(model$top$matrices$es$labels)]
		model = omxSetParameters(model, labels = toset, free = FALSE, values = 0)
	} else {
		# set the first column off, bar r1
		model = omxSetParameters(model, labels = "es_r[^1]0-9?c1", free = FALSE, values = 0)

		# toset  = model$top$matrices$es$labels[lower.tri(model$top$matrices$es$labels)]
		# model = omxSetParameters(model, labels = toset, free = FALSE, values = 0)
		# toset  = model$top$matrices$es$labels[lower.tri(model$top$matrices$es$labels)]
		# model = omxSetParameters(model, labels = toset, free = FALSE, values = 0)

		# Used to drop the ei paths, as we have a full Cholesky for E, now just set the bottom row TRUE
		# toset = umxGetParameters(model, "^ei_r.c.", free= TRUE)
		# model = omxSetParameters(model, labels = toset, free = FALSE, values = 0)
	}

	if(addStd){
		newTop = mxModel(model$top,
			# nVar Identity matrix
			mxMatrix("Iden", nrow = nVar, name = "I"),
			# inverse of standard deviation diagonal  (same as "(\sqrt(I.Vtot))~"
			mxAlgebra(solve(sqrt(I * ACE)), name = "SD"),
			# Standard general path coefficients
			mxAlgebra(SD %*% ai, name = "ai_std"), # standardized ai
			mxAlgebra(SD %*% ci, name = "ci_std"), # standardized ci
			mxAlgebra(SD %*% ei, name = "ei_std"), # standardized ei
			# Standardize specific path coefficients
			mxAlgebra(SD %*% as, name = "as_std"), # standardized as
			mxAlgebra(SD %*% cs, name = "cs_std"), # standardized cs
			mxAlgebra(SD %*% es, name = "es_std")  # standardized es
		)
		model = mxModel(model, newTop)
		if(addCI){
			model = mxModel(model, mxCI(c('top.ai_std', 'top.ci_std', 'top.ei_std', 'top.as_std', 'top.cs_std', 'top.es_std')))
		}
	}
	model  = omxAssignFirstParameters(model) # ensure parameters with the same label have the same start value... means, for instance.
	model = as(model, "MxModelIP")
	model = xmu_safe_run_summary(model, autoRun = autoRun, tryHard = tryHard)
	return(model)
} # end umxIP