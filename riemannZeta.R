##  First zero on the critical line s = 0.5 + i t
## Not run: 
require(pracma)
x <- seq(0, 20, len=1001)
z <- 0.5 + x*1i
fr <- Re(zeta(z))
fi <- Im(zeta(z))
fa <- abs(zeta(z))
plot(x, fa, type="n", xlim = c(0, 20), ylim = c(-1.5, 2.5),
      xlab = "Imaginary part (on critical line)", ylab = "Function value",
      main = "Riemann's Zeta Function along the critical line")
 lines(x, fr, col="blue")
 lines(x, fi, col="darkgreen")
 lines(x, fa, col = "red", lwd = 2)
 points(14.1347, 0, col = "darkred")
 legend(0, 2.4, c("real part", "imaginary part", "absolute value"),
        lty = 1, lwd = c(1, 1, 2), col = c("blue", "darkgreen", "red"))
 grid()
 
 ## End(Not run)