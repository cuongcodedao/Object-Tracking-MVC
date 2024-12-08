package model.bean;

public enum YoloVersion {
    YOLOV5("yolov5n.pt"),
    YOLOV6("yolov6n.pt"),
    YOLOV7("yolov7n.pt"),
    YOLOV8("yolov8n.pt"),
    YOLOV9("yolov9n.pt"),
    YOLOV10("C:/Users/Dang Van Cuong/Downloads/yolov10n.pt"),
    YOLOV11("yolov11n.pt");

    private final String path;
    YoloVersion(String path){
        this.path = path;
    }

    public String getPath(){
        return path;
    }
}
