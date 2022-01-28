""" Making the Grade module """


def round_scores(student_scores: list[float, int]) -> list[int]:
    """
    :param student_scores: list of student exam scores as float or int.
    :return: list of student scores *rounded* to nearest integer value.
    """

    rounded = []
    for score in student_scores:
        rounded.append(round(score))

    return rounded


def count_failed_students(student_scores: list[int]) -> int:
    """
    :param student_scores: list of integer student scores.
    :return: integer count of student scores at or below 40.
    """

    count = 0
    for score in student_scores:
        if score <= 40:
            count = count + 1

    return count


def above_threshold(student_scores: list[int], threshold: int) -> list[int]:
    """
    :param student_scores: list of integer scores
    :param threshold :  integer
    :return: list of integer scores that are at or above the "best" threshold.
    """

    best_scores = []
    for score in student_scores:
        if score >= threshold:
            best_scores.append(score)

    return best_scores


def letter_grades(highest: int) -> list[int]:
    """
    :param highest: integer of highest exam score.
    :return: list of integer lower threshold scores for each D-A letter grade interval.
             For example, where the highest score is 100, and failing is <= 40,
             The result would be [41, 56, 71, 86]:

             41 <= "D" <= 55
             56 <= "C" <= 70
             71 <= "B" <= 85
             86 <= "A" <= 100
    """

    interval = ((highest - 40) // 4)
    lower_thresholds = [41]
    for _ in range(1, 4):
        lower_thresholds.append(lower_thresholds[-1] + interval)

    return lower_thresholds


def student_ranking(student_scores: list[int], student_names: list[str]) -> list[str]:
    """
     :param student_scores: list of scores in descending order.
     :param student_names: list of names in descending order by exam score.
     :return: list of strings in format ["<rank>. <student name>: <score>"].
     """

    result: list[str] = []
    for i, score in enumerate(student_scores):
        result.append("{}. {}: {}".format(i + 1, student_names[i], score))

    return result


def perfect_score(student_info: list[str, int]) -> list[str]:
    """
    :param student_info: list of [<student name>, <score>] lists
    :return: first `[<student name>, 100]` or `[]` if no student score of 100 is found.
    """

    result = []
    for info in student_info:
        if info[1] == 100:
            result = info
            break

    return result
