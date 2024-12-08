import imageio
from ultralytics import YOLO
import sys

# # Đường dẫn mô hình YOLO
#
# model_path = "C:/Users/Dang Van Cuong/Downloads/yolov10n.pt"

def main(video_path, output_path, model_path):
    # Tải mô hình YOLOv10
    model = YOLO(model_path)

    # Mở video đầu vào
    reader = imageio.get_reader(video_path)
    fps = reader.get_meta_data()['fps']
    total_frames = reader.count_frames()  # Tổng số frame

    # Thiết lập video writer để ghi video đầu ra
    writer = imageio.get_writer(output_path, fps=fps)

    processed_frames = 0  # Số frame đã xử lý

    for frame in reader:
        results = model.track(frame, persist=True)
        frame_ = results[0].plot()

        # Ghi frame đã xử lý vào video đầu ra
        writer.append_data(frame_)

        # Cập nhật tiến độ
        processed_frames += 1
        progress = (processed_frames / total_frames) * 100
        print(f"PROGRESS: {progress:.2f}%")

    # Giải phóng tài nguyên
    writer.close()
    print("Xử lý xong video:", output_path)

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Cách sử dụng: python script.py <video_đầu_vào> <video_đầu_ra>")
        sys.exit(1)

    video_path = sys.argv[1]
    output_path = sys.argv[2]
    model_path = sys.argv[3]
    main(video_path, output_path, model_path)
