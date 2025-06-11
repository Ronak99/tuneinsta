import datetime


def get_firebase_build_name() -> str:
    date = datetime.datetime.now()
    return date.strftime("%y.%m.%d")


if __name__ == "__main__":
    print(get_firebase_build_name())
