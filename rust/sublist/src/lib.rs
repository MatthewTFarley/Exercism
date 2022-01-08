#[derive(Debug, PartialEq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(list_a: &[T], list_b: &[T]) -> Comparison {
    if list_a == list_b {
        Comparison::Equal
    } else if list_a.is_empty() {
        Comparison::Sublist
    } else if list_b.is_empty() {
        Comparison::Superlist
    } else {
        let (larger, smaller, list_type) = if list_a.len() > list_b.len() {
            (list_a, list_b, Comparison::Superlist)
        } else {
            (list_b, list_a, Comparison::Sublist)
        };

        for start in 0..larger.len() {
            let end = start + smaller.len();
            match larger.get(start..end) {
                Some(sublist) => {
                    if sublist == smaller {
                        return list_type;
                    }
                }
                None => return Comparison::Unequal,
            }
        }
        Comparison::Unequal
    }
}
