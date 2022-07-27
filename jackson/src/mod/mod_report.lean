import .contributing_factor
import ..concept.collection

universe u

structure time_utc : Type :=
(seconds_since_start_of_epoch : ℕ)

instance : has_repr time_utc := ⟨
  λ (t : time_utc), 
    has_to_string.to_string t.seconds_since_start_of_epoch
⟩

-- TODO: come up with an actual definition for UUID type
def uuid : Type := ℕ

instance : has_repr uuid := ⟨begin
  intro u,
  simp only [uuid] at u,
  exact has_repr.repr u,
end⟩

structure mod_report {c : Type u → Type u} [collection.has_collection c] : Type u :=
(time : time_utc)
(score : fin 11)
(id : uuid)
(contributing_factors : c contributing_factor)

namespace mod_report

def get_repr_instance (c : Type u → Type u) [collection.has_collection c] [has_repr (c contributing_factor)]
: has_repr (@mod_report c _)
:= ⟨
  λ (mr : mod_report),
    "{time: " ++ has_repr.repr mr.time ++
    ", score: " ++ has_repr.repr mr.score ++
    ", uuid: " ++ has_repr.repr mr.id ++
    ", contributing_factors: " ++ has_repr.repr mr.contributing_factors ++ "}"
⟩

-- ACTIONS

def set_time {c : Type u → Type u} [hc : collection.has_collection c] : @mod_report c hc → time_utc → @mod_report c hc
| ⟨t₀, s, u, cf⟩ t := ⟨t, s, u, cf⟩

def set_score {c : Type u → Type u} [hc : collection.has_collection c] : @mod_report c hc → fin 11 → @mod_report c hc
| ⟨t, s₀, u, cf⟩ s := ⟨t, s, u, cf⟩

def set_uuid {c : Type u → Type u} [hc : collection.has_collection c] : @mod_report c hc → uuid → @mod_report c hc
| ⟨t, s, u₀, cf⟩ u := ⟨t, s, u, cf⟩

def set_contributing_factors {c : Type u → Type u} [hc : collection.has_collection c] : @mod_report c hc → c contributing_factor → @mod_report c hc
| ⟨t, s, u, cf₀⟩ cf := ⟨t, s, u, cf⟩

end mod_report