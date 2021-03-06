% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fit_and_reporting.R
\name{plot.MxModel}
\alias{plot.MxModel}
\alias{plot}
\alias{umxPlot}
\title{Create and display a graphical path diagram for a model.}
\usage{
\method{plot}{MxModel}(
  x = NA,
  std = FALSE,
  fixed = TRUE,
  means = TRUE,
  digits = 2,
  file = "name",
  labels = c("none", "labels", "both"),
  resid = c("circle", "line", "none"),
  strip_zero = FALSE,
  splines = TRUE,
  min = NULL,
  same = NULL,
  max = NULL,
  ...
)
}
\arguments{
\item{x}{An \code{\link[=mxModel]{mxModel()}} from which to make a path diagram}

\item{std}{Whether to standardize the model (default = FALSE).}

\item{fixed}{Whether to show fixed paths (defaults to TRUE)}

\item{means}{Whether to show means or not (default = TRUE)}

\item{digits}{The number of decimal places to add to the path coefficients}

\item{file}{The name of the dot file to write: NA = none; "name" = use the name of the model}

\item{labels}{Whether to show labels on the paths. "none", "labels", or "both" (parameter + label).}

\item{resid}{How to show residuals and variances default is "circle". Options are "line" & "none"}

\item{strip_zero}{Whether to strip the leading "0" and decimal point from parameter estimates (default = FALSE)}

\item{splines}{Whether to allow lines to curve: defaults to TRUE (nb: some models look better with FALSE)}

\item{min}{optional list of objects to group at the top of the plot. Default (NULL) chooses automatically.}

\item{same}{optional list of objects to group at the same rank in the plot. Default (NULL) chooses automatically.}

\item{max}{optional list of objects to group at the bottom of the plot. Default (NULL) chooses automatically.}

\item{...}{Optional parameters}
}
\description{
\code{\link[=plot]{plot()}} produces SEM diagrams in graphviz format, and relies on \code{\link[=DiagrammeR]{DiagrammeR()}} (or a
graphviz application) to create the image.
\emph{Note:} DiagrammeR is supported out of the box.  By default, plots open in your browser.
}
\details{
If you use umx_set_plot_format("graphviz"), they will open in a graphviz helper app (if installed).
The commercial application \dQuote{OmniGraffle} is great for editing these images.
On unix and windows, \code{\link[=plot]{plot()}} will create a pdf and open it in your default pdf reader.

If you use graphviz, we try and use that app, but YOU HAVE TO INSTALL IT!

\emph{MacOS note}: On Mac, we will try and open an app: you may need to associate the \sQuote{.gv}
extension with the graphviz app.
Find the .gv file made by plot, get info (cmd-I), then choose \dQuote{open with},
select graphviz.app (or OmniGraffle professional),
then set \dQuote{change all}.
}
\examples{
\dontrun{
require(umx)
data(demoOneFactor)
manifests = names(demoOneFactor)
m1 = umxRAM("One Factor", data = demoOneFactor, type = "cov",
	umxPath("G", to = manifests),
	umxPath(var = manifests),
	umxPath(var = "G", fixedAt = 1)
)
plot(m1)
plot(m1, std = TRUE, resid = "line", digits = 3, strip_zero = FALSE)


m1 = umxRAM("grow", data = myGrowthMixtureData,
	umxPath(var = manifests, free = TRUE), 
	umxPath(means = manifests, fixedAt = 0), 
	umxPath(v.m. = c("intercept","slope")),
	umxPath("intercept", with = "slope"),
	umxPath("intercept", to = manifests, fixedAt = 1), 
	umxPath("slope", to = manifests, arrows = 1, fixedAt = c(0, 1, 2, 3, 4))
)

plot(m1, means=FALSE, std=TRUE, strip=TRUE, splines="FALSE", max="intercept")
} # end dontrun

}
\references{
\itemize{
\item \url{https://www.github.com/tbates/umx}, \url{https://en.wikipedia.org/wiki/DOT_(graph_description_language)}
}
}
\seealso{
\itemize{
\item \code{\link[=umx_set_plot_format]{umx_set_plot_format()}}, \code{\link[=plot.MxModel]{plot.MxModel()}}, \code{\link[=umxPlotACE]{umxPlotACE()}}, \code{\link[=umxPlotCP]{umxPlotCP()}}, \code{\link[=umxPlotIP]{umxPlotIP()}}, \code{\link[=umxPlotGxE]{umxPlotGxE()}}
}

Other umx S3 functions: \code{\link{plot.MxLISRELModel}()}

Other Plotting functions: \code{\link{plot.MxLISRELModel}()},
  \code{\link{umxPlotACEcov}()},
  \code{\link{umxPlotACEv}()}, \code{\link{umxPlotACE}()},
  \code{\link{umxPlotCP}()}, \code{\link{umxPlotGxEbiv}()},
  \code{\link{umxPlotGxE}()}, \code{\link{umxPlotIP}()},
  \code{\link{umxPlotSexLim}()},
  \code{\link{umxPlotSimplex}()}, \code{\link{umx}}
}
\concept{Plotting functions}
\concept{umx S3 functions}
