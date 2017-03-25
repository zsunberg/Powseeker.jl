immutable Downhill{G<:Function} <: Policy
    gradient::G
end
Downhill(p::PowseekerProblem) = Downhill(mdp(p).gradient)

function action(p::Downhill, s::SkierState)
    grad = p.gradient(s.pos)
    steepest = atan2(-grad[2], -grad[1])
    return steepest - s.psi
end

immutable Topout{G<:Function} <: Policy
    mdp::PowseekerMDP{G}
    tol::Float64
end
Topout(p::PowseekerProblem, tol::Float64) = Topout(mdp(p), tol)

function action(p::Topout, s::SkierState)
    grad = p.mdp.gradient(s.pos)
    if s.time >= p.mdp.duration || norm(grad) < p.tol # topped out
        return action(Downhill(p.mdp.gradient), s)
    else
        up = atan2(grad[2], grad[1])
        return up-s.psi
    end
end

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
