import numpy as np
from matplotlib import pyplot as plt
from scipy.integrate import odeint
import argparse

parser = argparse.ArgumentParser(add_help=False)

parser.add_argument("--alpha", type=float, default=.2)
parser.add_argument("--beta", type=float, default=.2)
parser.add_argument("--delta", type=float, default=.2)
parser.add_argument("--gamma", type=float, default=8)
parser.add_argument("--w", type=float, default=.2)

args = parser.parse_args()
alpha = args.alpha
beta = args.beta
delta = args.delta
gamma = args.gamma
w = args.w



def duffing(v, t):
    x, y, tita = v[0],v[1],v[2]
    dx = y
    dy = - delta * y - alpha * x - beta * x**3 + gamma * np.cos(tita)
    dtita = w
    return [dx, dy, dtita]

dt = 0.01
T=2*np.pi/w
tiempo = np.arange(0,200*T,dt)
x0 = [1,1,0]
sol = odeint(duffing,x0,tiempo)

x, y, tita = sol[:,0], sol[:,1], sol[:,2]
plt.figure(figsize=(10,10))
# plt.title(r'$\alpha = $' + str(np.round(alpha),2) + r'$\beta = $' +str(np.round(beta),2)  + r'$\delta = $' str(np.round(delta),2)+ r'$\gamma = $ ' + str(np.round(gamma),2) + r'$\omega = $' + str(np.round(omega),2))

# plt.title("alpha, beta, delta, gamma, w = {}".format([alpha, beta, delta, gamma, w]))
plt.plot(x,y, color="black", alpha=0.7, linewidth=3)
plt.show()
