extends Control

func change_displayed_rounds(r):
	if r > 99:
		
		if r >= 900:
			$rounds_left_count1.set("frame", 9)
			r = r - 900
		elif r >= 800:
			$rounds_left_count1.set("frame", 8)
			r = r - 800
		elif r >= 700:
			$rounds_left_count1.set("frame", 7)
			r = r - 700
		elif r >= 600:
			$rounds_left_count1.set("frame", 6)
			r = r - 600
		elif r >= 500:
			$rounds_left_count1.set("frame", 5)
			r = r - 500
		elif r >= 400:
			$rounds_left_count1.set("frame", 4)
			r = r - 400
		elif r >= 300:
			$rounds_left_count1.set("frame", 3)
			r = r - 300
		elif r >= 200:
			$rounds_left_count1.set("frame", 2)
			r = r - 200
		else:
			$rounds_left_count1.set("frame", 1)
			r = r - 100
			
	else:
		$rounds_left_count1.set("frame", 0)
		
	change_displayed_rounds_2(r)
	
func change_displayed_rounds_2(r):
	if r > 9:
		
		if r >= 90:
			$rounds_left_count2.set("frame", 9)
			r = r - 90
		elif r >= 80:
			$rounds_left_count2.set("frame", 8)
			r = r - 80
		elif r >= 70:
			$rounds_left_count2.set("frame", 7)
			r = r - 70
		elif r >= 60:
			$rounds_left_count2.set("frame", 6)
			r = r - 60
		elif r >= 50:
			$rounds_left_count2.set("frame", 5)
			r = r - 50
		elif r >= 40:
			$rounds_left_count2.set("frame", 4)
			r = r - 40
		elif r >= 30:
			$rounds_left_count2.set("frame", 3)
			r = r - 30
		elif r >= 20:
			$rounds_left_count2.set("frame", 2)
			r = r - 20
		else:
			$rounds_left_count2.set("frame", 1)
			r = r - 10
			
	else:
		$rounds_left_count2.set("frame", 0)
		
	change_displayed_rounds_3(r)
	
func change_displayed_rounds_3(r):
	if r == 9:
		$rounds_left_count3.set("frame", 9)
	elif r == 8:
		$rounds_left_count3.set("frame", 8)
	elif r == 7:
		$rounds_left_count3.set("frame", 7)
	elif r == 6:
		$rounds_left_count3.set("frame", 6)
	elif r == 5:
		$rounds_left_count3.set("frame", 5)
	elif r == 4:
		$rounds_left_count3.set("frame", 4)
	elif r == 3:
		$rounds_left_count3.set("frame", 3)
	elif r == 2:
		$rounds_left_count3.set("frame", 2)
	elif r == 1:
		$rounds_left_count3.set("frame", 1)
	else:
		$rounds_left_count3.set("frame", 0)
