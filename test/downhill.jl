using Powseeker
using POMDPs
using POMDPToolbox
using Plots

mdp = PowseekerMDP()
policy = Downhill()
hr = HistoryRecorder(max_steps=100)
is = SkierState(1, [1200, 0], 0)

hist = simulate(hr, mdp, policy, is)

plot(mdp)
plot!(hist)
gui()
