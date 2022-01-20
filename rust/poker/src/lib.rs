/// Given a list of poker hands, return a list of those hands which win.
///
/// Note the type signature: this function should return _the same_ reference to
/// the winning hand(s) as were passed in, not reconstructed strings which happen to be equal.
pub fn winning_hands<'a>(hands: &[&'a str]) -> Vec<&'a str> {
    dbg!(hands);
    if hands.len() == 1 {
        hands.to_vec()
    } else if hands.iter().all(|x| x == &hands[0]) {
        hands.to_vec()
    } else {
        Vec::new()
    }
}
