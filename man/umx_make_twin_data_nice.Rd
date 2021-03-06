% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/umx_nice_data.R
\name{umx_make_twin_data_nice}
\alias{umx_make_twin_data_nice}
\title{Convert a twin dataset into umx standard format.}
\usage{
umx_make_twin_data_nice(data, sep, zygosity, numbering)
}
\arguments{
\item{data}{a \code{\link[=data.frame]{data.frame()}} to check/convert.}

\item{sep}{existing separator string (will be updated to "_T").}

\item{zygosity}{existing zygosity column name (will be renamed \code{zygosity}).}

\item{numbering}{existing twin sequence string (will be updated to _T1, _T2, _T3).}
}
\value{
\itemize{
\item \code{\link[=data.frame]{data.frame()}}
}
}
\description{
\code{umx_make_twin_data_nice} is a function to convert your twin data into a format used across \code{umx}. Specifically:
\enumerate{
\item Existing column for zygosity is renamed to "zygosity".
\item \code{sep} is set to "_T"
\item The twinID is is set to sequential digits, i.e. 1,2...
}
}
\examples{
tmp = umx_make_twin_data_nice(twinData, sep="", numbering = 1:5, zyg="zygosity")
namez(tmp)
# m1 = umxACE("wt")

}
\references{
\itemize{
\item \href{https://tbates.github.io}{tutorials}, \href{https://github.com/tbates/umx}{tbates/umx}
}
}
\seealso{
\itemize{
\item \code{\link[=umx_wide2long]{umx_wide2long()}}, \code{\link[=umx_long2wide]{umx_long2wide()}},
}

Other Twin Data functions: \code{\link{umx_long2wide}()},
  \code{\link{umx_make_TwinData}()},
  \code{\link{umx_residualize}()},
  \code{\link{umx_scale_wide_twin_data}()},
  \code{\link{umx_wide2long}()}, \code{\link{umx}}
}
\concept{Twin Data functions}
