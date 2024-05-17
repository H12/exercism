#[derive(Debug, PartialEq)]
pub struct Clock {
    hours: i32,
    minutes: i32,
}

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        let mut rolled_hours = (hours + minutes / 60) % 24;
        let mut rolled_minutes = minutes % 60;

        if rolled_minutes < 0 {
            rolled_hours -= 1;
            rolled_minutes += 60;
        }

        if rolled_hours < 0 {
            rolled_hours += 24;
        }

        return Clock {
            hours: rolled_hours,
            minutes: rolled_minutes,
        };
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        Clock::new(self.hours, self.minutes + minutes)
    }
}

impl std::fmt::Display for Clock {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{:02}:{:02}", self.hours, self.minutes)
    }
}
