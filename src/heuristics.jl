immutable Downhill{G<:Function} <: Policy
    gradient::G
end
Downhill(p::PowseekerProblem) = Downhill(mdp(p).gradient)

function action(p::Downhill, s::SkierState)
    grad = p.gradient(s.pos)
    steepest = atan2(-grad[2], -grad[1])
    return steepest - s.psi
end

#=
immutable Topout <: Policy end

function action(::Topout, s::SkierState)
    grad
end
=#

#=
@with_kw immutable Center <: Policy
    rng::MersenneTwister = MersenneTwister(14)
end

function action(::Center, s::SkierState)
    center = atan2
end

function action(p::Center, c::ParticleCollection)
    s = rand(p.rng, c)
    return GPSOrAngle(false, action(p, s))
end
=#
