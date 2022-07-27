universe u

structure time_utc : Type :=
(seconds_since_start_of_epoch : ℕ)

instance : has_repr time_utc := ⟨
  λ (t : time_utc), 
    has_to_string.to_string t.seconds_since_start_of_epoch
⟩

